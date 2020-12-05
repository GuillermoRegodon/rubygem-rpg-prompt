require "rpg-prompt/rules_default_hashes.rb"
require "rpg-prompt/message.rb"
require "rpg-prompt/texts_default.rb"
require "rpg-prompt/keypress.rb"

module Rules
  class Sheet < Hash
    def initialize(short_name)
      self[:short_name] = short_name
      super(false)
    end

    def load_attribute(attribute, value)
      self[attribute] = value
    end

    def read_attribute(attribute)
      self[attribute]
    end

    def set_attribute(attribute, value)
      c_a = self.creation_array
      if c_a.key?(attribute)
        type = c_a[attribute][1]
        el = case type
        when :integer
          Integer(value)
        when :float
          Float(value)
        when :bool
          case value
          when "true"
            true
          when "false"
            false
          else
            puts 747390
            false
          end
        when :weapon
          value = value.gsub("_", " ")
          if Message.weapon_symbol(value)
            Message.weapon_symbol(value)
          else
            return_symbol = :set_fail
            self[attribute]
          end
        else
          value
        end
        self[attribute] = el.clone
      end
      unless (return_symbol == :set_fail)
        return_symbol = :set_attribute
      end
      return_symbol
    end

    def clone_sheet(sheet)
      sheet.each { |key, val|
        self[key] = val
      }
    end

    def remove_extra_separators(line)
      ret_line = String.new(line)
      ret_line = ret_line.gsub(/\s+/, " ")
      ret_line = ret_line.gsub(/^\s*/, "")
      ret_line = ret_line.gsub(/\s*$/, "")
      ret_line = ret_line.gsub(/,/, "")
    end

    def create_new_w_questions
      creation_array = self.creation_array
      creation_array.each do |key, question|
        unless question[0] == :no_question
          Message.question(question[0])

          if question[1] == :string
            val = $stdin.gets.chomp
            val = remove_extra_separators(val)
            if val.length == 0
              val = question[2]
            end

          elsif question[1] == :integer
            i = $stdin.gets.chomp
            if i.length == 0
              val = question[2]
            else
              begin
                val = Integer(i)
              rescue ArgumentError
                redo
              end
            end

          elsif question[1] == :float
            i = $stdin.gets.chomp
            if i.length == 0
              val = question[2]
            else
              begin
                val = Float(i)
              rescue ArgumentError
                redo
              end
            end

          elsif question[1] == :bool
            b = $stdin.gets.chomp
            b = remove_extra_separators(b)
            if b.length == 0
              val = question[2]
            elsif (b == "s") || (b == "si")
              val = true
            elsif (b == "n") || (b == "no")
              val = false
            else
              redo
            end

          elsif question[1] == :multiple
            val = Array.new
            loop do
              name = $stdin.gets.chomp
              name = remove_extra_separators(name)
              if name == "q"
                break
              else
                val.push(name)
              end
            end

          elsif question[1] == :weapon
            weapon_hash = RulesHashes::WeaponHash.new
            available = weapon_hash.weapons
            translated = Array.new
            available.each do |e|
              translated.push(Message.weapon_word(e))
            end
            Message.puts_weapons_list(available)
            s = $stdin.gets.chomp
            s = remove_extra_separators(s)
            unless translated.include?(s)
              redo
            end
            val = Message.weapon_symbol(s)

          elsif question[1] == :armor
            armor_hash = RulesHashes::ArmorHash.new
            available = armor_hash.armors
            translated = Array.new
            available.each do |e|
              translated.push(Message.armor_word(e))
            end
            Message.puts_armors_list(available)
            s = $stdin.gets.chomp
            s = remove_extra_separators(s)
            unless translated.include?(s)
              redo
            end
            val = Message.armor_symbol(s)

          else
            puts 367223
          end
          load_attribute(key, val)
        else
          load_attribute(key, question[2])
        end
      end
    end

    def full_name
      String.new(self[:full_name] + " " + self[:nickname])
    end

    def add_ability(ability)
      case ability
      when :sing
        @abilities[:sing] = true
      when :dance
        @abilities[:dance] = true
      end
    end

    def remove_ability(ability)
      @abilities[ability] = false
    end

    def []=(key, el)
      if (key == :hp) || (key == :dead_in)
        if el <= 0
          super(key, el)
          if key == :hp
            Message.message(:mortal_wound_hp)
          elsif key == :dead_in
            Message.message(:mortal_wound_dead_in)
          end
        end
      end
      super(key, el)
    end

    def dead?
      if self[:dead_in] != false
        (self[:hp] <= 0) || (self[:dead_in] <= 0)
      else
        (self[:hp] <= 0)
      end
    end

    def health?
      self[:hp]
    end

    def spawned?
      self[:spawned]
    end

    def reduce_health(damage)
      self[:hp] -= damage
    end

    def move_capacity?
      @move_capacity
    end

    def pass_round
      self.each do |key, el|
        case key
        when :dead_in
          self[key] -= 1
        end
      end
    end
  end

  class Character < Sheet
    def initialize(short_name)
      super(short_name)
      @creation_array = RulesHashes::CreationArray.new()
    end
    def creation_array
      @creation_array
    end
    def unique?
      true
    end
    def good?
      true
    end
  end

  class Foe < Sheet
    def initialize(short_name)
      super(short_name)
      @creation_array = RulesHashes::CreationArray.new()
    end
    def creation_array
      @creation_array
    end
    def unique?
      true
    end
    def good?
      false
    end
  end

  class Spawn < Foe
    def initialize(short_name)
      super(short_name)
      @creation_array = RulesHashes::CreationArray.new()
      @creation_array[:full_name] = [:question_full_name, :multiple, nil]
      @creation_array[:nickname] = [:question_nickname, :multiple, nil]
    end
    def creation_array
      @creation_array
    end
    def unique?
      false
    end
    def good?
      false
    end

    def create_new_w_questions
      super
      @short_name = read_attribute(:short_name)
      @hp = read_attribute(:hp)
      @full_name = read_attribute(:full_name)
      @nickname = read_attribute(:nickname)
    end

    def get_random_full_name(short_name, name_list)
      get_random(short_name, name_list, :full_name)
    end

    def get_random_nickname(short_name, name_list)
      get_random(short_name, name_list, :nickname)
    end

    def full_name
      String.new("enemy of kind " + self[:short_name])
    end

    def get_random(name_list)
      r = rand(name_list.length)
      name_list[r]
    end

    def clone_sheet(sheet, short_name)
      sheet.each do |key, val|
        if key == :short_name
          self.load_attribute(:short_name, short_name)
        elsif (key == :full_name) || (key == :nickname)
          self.load_attribute(key, get_random(sheet[key]))
        else
          self.load_attribute(key, val)
        end
      end
    end
  end
end