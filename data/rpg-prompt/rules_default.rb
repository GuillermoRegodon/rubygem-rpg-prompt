# default value
$system = "default"

if File.exists?(Settings_file_name)
  File.readlines(Settings_file_name).each do |line|
    m = line.match(/(?<setting>\w*): (?<val>\w*)/)
    if m == nil
      break
    else
      case m[:setting]
      when "system"
        $system = m[:val]
      end
    end
  end
end

unless $system == "default"
  $hashes_file_name = "./rules_" + $system + "_hashes.rb"
  unless (File.exist?($rules_file_name)) && (File.exist?($hashes_file_name)) && (File.exist?($texts_file_name))
    Message.message(:wrong_config)
    return -1
  end
else
  $hashes_file_name = "rpg-prompt/rules_default_hashes.rb"
end

require $hashes_file_name

require "rpg-prompt/message.rb"
require "rpg-prompt/texts_default.rb"
require "rpg-prompt/keypress.rb"
require "rpg-prompt/parse_line.rb"


# With these lines, we include the options available for the attacks and the
# actions. You may also include more commands or more options for these
# commands. I have included a version of the commands with full words and
# with abbreviatures. Take special care that no two regular expressions match
# the same input line!

ParseLine::Line.add_command(:hits,
  /(?<atk>\w+) hits (?<def>\w+)/,
  ["c", "f", "r", "h", "s", "u", "d"])
ParseLine::Line.add_command(:hits_short,
  /(?<atk>\w+) h (?<def>\w+)/,
  ["c", "f", "r", "h", "s", "u", "d"])

ParseLine::Line.add_command(:skill,
  /skill (?<ch>\w+) (?<skill>\w+)( [+-]\d+)?/,
  ["c", "e", "m", "h"])
ParseLine::Line.add_command(:skill_short,
  /(?<ch>\w+)( )?:( )?(?<skill>\w+)( [+-]\d+)?/,
  ["c", "e", "m", "h"])


# Rules module
module Rules

  # Module to define the possible rolls
  module Dice

    # The roll itself
    def self.roll(type_of_roll)
      case type_of_roll
      when :d6
        1+rand(6)
      when :d10
        1+rand(10)
      end
    end

    # A small prompt to require a roll o perfomr a random roll
    def self.prompt_roll(type_of_roll)
      case type_of_roll
      when :d6
        roll_prompt = :ask_for_d6
        roll_limit = 6
      else
        roll_prompt = :ask_for_d10
        roll_limit = 10
      end
      roll = 0
      Message.message(:preset_roll_prompt)
      case Keypress.read_char
      when "r"
        Message.message(roll_prompt)
        loop do
          roll = $stdin.gets.to_i
          if (roll > roll_limit) || (roll <= 0)
            Message.message(:bad_range)
            redo
          else
            Message.help(:rolling, {roll: roll})
          end
          break
        end
      else
        roll = Dice.roll(type_of_roll)
        Message.help(:rolling, {roll: roll})
      end
      roll
    end
  end

  # Generic type of Turn for a character
  class Turn
    def resolve
    end
  end

  # Attack turn.
  # A new AttackTurn object is created for each attack action
  #    - The initializer receives the attacker and the defender sheets, from
  #      where it extracts the attacker weapon and defender armor used
  #    - The process_options method is the key help of this gem. The options
  #      from your rules system are coded into characters to be used in the 
  #      prompt after a '-'
  #    - The resolve method resolves the attack action
  class AttackTurn
    @no_damage = nil
    @modifier = nil

    # Extracts the attacker weapon and defender armor used
    # Defines the globals to handle the options
    def initialize(attacker_sheet, defender_sheet)
      @attacker_sheet = attacker_sheet
      @defender_sheet = defender_sheet
      @weapon = Weapon.new(@attacker_sheet)
      @armor = Armor.new(@defender_sheet)
      if @no_damage == nil
        @no_damage = false
        @modifier = 0
      end
    end

    # Process the options matching a rule with a character to be typed
    # in the prompt after a slash
    def process_options(options)
      @no_damage = false
      @modifier = 0
      distance = 0
      options.each do |option|
        c = option[0]
        option[0] = ' '
        case c
        when 'c' #check modifiers, no damage is done
          @no_damage = true
        when 'f' #flank attack
          @modifier += 1
        when 'r' #attack from the rear
          @modifier += 2
        when 'h' #higher ground
          @modifier += 1
        when 's' #surprise
          @modifier += 2
        when 'u' #attack while unsheathing
          @modifier -= -1
        when 'd' #distance modifier
          distance += 1
        end
      end
      if (distance > 0) && (distance < @weapon.weapon[:distance_mod].length)
        @modifier += @weapon.weapon[:distance_mod][distance][1]
      elsif (distance > 0) && (distance >= @weapon.weapon[:distance_mod].length)
        @no_damage = true
      end
      return @no_damage, @modifier
    end

    #helper method for resolve. It prompts the modifier
    def mod_roll(roll)
      r = roll + @modifier
      Message.help(:attack_roll, {r: r, roll: roll, modifier: @modifier})
      r
    end
    
    # Resolves the attack, with the modifier from process_options
    def resolve
      # In these rules, attacks are resolved with  d10
      roll = Dice.prompt_roll(:d10)
      mod_roll = mod_roll(roll)
      
      # damage may be different for each weapon-armor combination
      damage = @weapon.damage_roll(@armor, mod_roll)

      # unless check option, reduce defender health points
      unless @no_damage then @defender_sheet.reduce_health(damage) end
      
      if damage > 0
        Message.help(:hits_lose_hp,
          {full_name: @defender_sheet.full_name, damage: damage})
      end
    end
  end

  # Action turn
  # Characters can perform non attack actions, with modifier
  class ActionTurn < Turn
    @@skill_hash = nil
    @skill_sym = nil

    # If the character has a bonus in he skill, it is added to the modifiers
    # Note that in these simple set of rules, no character ever has a bonus,
    #  because it was not included in the character creation Questionnaire.
    # A bonus can be given using the set command.
    def initialize(sheet, skill)
      @sheet = sheet
      unless @skill_sym
        @skill_sym = Message.skill_symbol(skill)
        @@skill_hash = RulesHashes::SkillHash.new
      end
      @skill_bonus = @sheet[@skill_sym] ? @sheet[@skill_sym] : 0
    end

    # checks if the skill has been defined in RulesHashes
    def self.skill?(skill)
      unless @skill_sym
        @skill_sym = Message.skill_symbol(skill)
        @@skill_hash = RulesHashes::SkillHash.new
      end
      @@skill_hash.key?(@skill_sym)
    end
  
    # In these simple set of rules, only a basic difficulty rule is included
    def process_options(options, command_mod)
      @modifier = command_mod
      @no_action = false
      options.each do |option|
        c = option[0]
        option[0] = ' '
        case c
        when 'c' #check
          @no_action = true
        when 'e' #easy
          @modifier += 3
        when 'm' #medium
          @modifier += 0
        when 'h' #hard
          @modifier -= 3
        end
      end
      @modifier += @skill_bonus
      return @no_action, @modifier
    end

    # Helper method for action_table_result. It guarantees in range 
    def truncate_val(v)
      v = (v > 500) ? 500 : v
      v = (v < -500) ? -500 : v
    end

    # Checks for the result in the ActionTable
    def action_table_result(roll)
      r = truncate_val(roll)
      @@action_table = RulesHashes::ActionTable.new
      action_result = :failure
      @@action_table.each do |ar, l|
        if (r >= l[0]) && (r < l[1])
          action_result = ar
        end
      end
      action_result
    end

    # Helper method for resolve. It prompts the modifier
    def mod_roll(roll)
      r = roll + @modifier
      Message.help(:skill_roll, {r: r, roll: roll, modifier: @modifier})
      r
    end

    # Rresolves the action, with the options from process_options
    def resolve
      roll = Dice.prompt_roll(:d10)
      action_result = action_table_result(mod_roll(roll))
      Message.skill_word(action_result)
    end
  end

  # Weapon
  # Each weapon is responsible of returning the damage that it can make to 
  # each armor, for a given modified roll. In these simple rules, the damage
  # is always a d6, if the modified roll surpasses the armor value
  class Weapon
    attr_accessor :weapon

    def initialize(sheet)
      @@weapon_hash = RulesHashes::WeaponHash.new()
      @weapon = @@weapon_hash[sheet[:weapon]]
    end

    def damage_roll(armor, mod_roll)
      if (mod_roll >= armor[:armor])
        Message.message(:hits_success)
        Dice.prompt_roll(:d6)
      else
        Message.message(:hits_fail)
        0
      end
    end
  end

  # Armor
  # Each armor has to provide enough information to the weapon for it to
  # calculate the damage. In these simple rules, it returns only a threshold
  # for each armor type
  class Armor < Hash
    def initialize(sheet)
      @@weapon_hash = RulesHashes::ArmorHash.new()
      self[:armor] = @@weapon_hash[sheet[:armor]]
    end
  end
end