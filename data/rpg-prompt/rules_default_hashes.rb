module RulesHashes

  # In this class, you may define the parameters that characterize the armor type
  # In these simple default rules, the value is just a number, but it can be
  # a Hash with any number of key=>element pairs
  class ArmorHash < Hash
    @@armors = nil

    def initialize
      self[:no_armor] = 0
      self[:hardened_leather] = 3
      self[:chainmail] = 5
      self[:plate] = 8

      @@armors = self.keys
    end

    def armors
      @@armors
    end
  end

  # In this class, you may define the parameters that characterize the weapon type
  # As with ArmorHash, the value may be a Hash with any number of key=>element pairs
  # In these simple default rules, the value is a combination of distance and malus
  # to the attack roll
  class WeaponHash < Hash
    @@weapons = nil

    def initialize
      self[:broad_sword] = {:distance_mod => []}
      self[:dagger] = {:distance_mod => []}
      self[:scimitar] = {:distance_mod => []}
      self[:hand_axe] = {:distance_mod => []}
      self[:composite_bow] = {:distance_mod => [[0,0], [30,0], [60,-3], [90,-6]]}
      self[:mace] = {:distance_mod => []}
      self[:warhammer] = {:distance_mod => []}
      self[:battle_axe] = {:distance_mod => []}
      self[:claw_and_bite] = {:distance_mod => []}

      @@weapons = self.keys
    end

    def weapons
      @@weapons
    end
  end

  # In this class, you define the variables of the warrior sheet.
  # The key is a symbol: :full_name, :nickname, :hp, :weapon and :armor
  # The elements is an array of three
  #     - The question symbol that has to match in the symbol in the
  #       Questionnaire in texts_system.rb
  #     - The type as a symbol: :string, :integer, :bool are supported
  #       :weapon and :armor are treated specificallly to list supported
  #       values and accept only values in that list
  #     - The default value.
  class CreationArray < Hash
    def initialize
      self[:full_name] = [:question_full_name, :string, nil]
      self[:nickname] = [:question_nickname, :string, nil]
      self[:race] = [:question_race, :string, ""] #not used
      self[:hp] = [:question_hp, :integer, 10]
      self[:weapon] = [:question_weapon, :weapon, :broad_sword]
      self[:armor] = [:question_armor, :armor, :no_armor]
      self[:move_capacity] = [:question_move_capacity, :integer, 10] #not used
    end
  end

  # In this class, you define the skills that the characters may use
  # The key is the essential definition. In these simple rules, the element is
  # just the type of skill.
  class SkillHash < Hash
    def initialize
      self[:sing] = [:artistic, :active]
      self[:stalk] = [:subterfuge, :stealth]
      self[:pick_locks] = [:subterfuge, :mechanics]
    end
  end

  # In this class, you may define the posible outcomes of the skill attempt.
  # The key is the result of the action, and the element is the range.
  # use -1000 and 1000 for the minimum and maximum values.
  # You may include partial success, spectacular failure, etc.
  class ActionTable < Hash
    def initialize
      self[:failure] = [-1000, 3]
      self[:success] = [4, 1000]
    end
  end
end
