require "rpg-prompt/rules_default_hashes.rb"
require "rpg-prompt/message.rb"
require "rpg-prompt/texts_default.rb"
require "rpg-prompt/keypress.rb"

ParseLine::Line.add_command(:hits,
  /(?<atk>\w+) hits (?<def>\w+)/, ["c", "f", "r", "h", "s", "u", "d"])
ParseLine::Line.add_command(:hits_short,
  /(?<atk>\w+) h (?<def>\w+)/, ["c", "f", "r", "h", "s", "u", "d"])

ParseLine::Line.add_command(:skill,
  /skill (?<ch>\w+) (?<skill>\w+)( [+-]\d+)?/,
  ["c", "r", "e", "l", "m", "h", "v", "e", "s", "a", "c", "u", "i", "d", "p"])
ParseLine::Line.add_command(:skill_short,
  /(?<ch>\w+)( )?:( )?(?<skill>\w+)( [+-]\d+)?/,
  ["c", "r", "e", "l", "m", "h", "v", "e", "s", "a", "c", "u", "i", "d", "p"])

module Rules
  module Dice
    def self.roll(type_of_roll)
      case type_of_roll
      when :d6
        1+rand(6)
      when :d10
        1+rand(10)
      end
    end

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

  class Turn
    def resolve
    end
  end

  class AttackTurn
    @no_damage = nil
    @modifier = nil

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

    def process_options(options)
      @no_damage = false
      @modifier = 0
      distance = 0
      options.each do |option|
        c = option[0]
        option[0] = ' '
        case c
        when 'c' #check
          @no_damage = true
        when 'f' #flank
          @modifier += 1
        when 'b' #back
          @modifier += 2
        when 'h' #higher ground
          @modifier += 1
        when 's' #surprise
          @modifier += 2
        when 'u' #unsheathing
          @modifier -= -1
        when 'd' #distance
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

    def resolve
      roll = Dice.prompt_roll(:d10)
      mod_roll = roll + @modifier
      
      damage = @weapon.damage_roll(@armor, mod_roll)

      unless @no_damage then @defender_sheet.reduce_health(damage) end
      
      if damage > 0
        Message.help(:hits_lose_hp,
          {full_name: @defender_sheet.full_name, damage: damage})
      end
    end
  end

  class ActionTurn < Turn
    @@skill_hash = nil
    @skill_sym = nil

    def initialize(sheet, skill)
      @sheet = sheet
      unless @skill_sym
        @skill_sym = Message.skill_symbol(skill)
        @@skill_hash = RulesHashes::SkillHash.new
      end
      @skill_bonus = @sheet[@skill_sym] ? @sheet[@skill_sym] : 0
    end

    def self.skill?(skill)
      unless @skill_sym
        @skill_sym = Message.skill_symbol(skill)
        @@skill_hash = RulesHashes::SkillHash.new
      end
      @@skill_hash.key?(@skill_sym)
    end

  
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

    def truncate_val(v)
      v = (v > 500) ? 500 : v
      v = (v < -500) ? -500 : v
    end

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

    def mod_roll(roll)
      r = roll + @modifier
      Message.help(:skill_roll, {r: r, roll: roll, modifier: @modifier})
      r
    end

    def resolve
      roll = Dice.prompt_roll(:d10)
      action_result = action_table_result(mod_roll(roll))
      Message.skill_word(action_result)
    end
  end

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

  class Armor < Hash
    def initialize(sheet)
      @@weapon_hash = RulesHashes::ArmorHash.new()
      self[:armor] = @@weapon_hash[sheet[:armor]]
    end
  end
end