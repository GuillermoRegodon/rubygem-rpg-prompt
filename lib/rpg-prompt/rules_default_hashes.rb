require "rpg-prompt/message.rb"

module RulesHashes
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

  class CreationArray < Hash
    def initialize
      self[:full_name] = [:question_full_name, :string, nil]
      self[:nickname] = [:question_nickname, :string, nil]
      self[:race] = [:question_race, :string, ""]
      self[:hp] = [:question_hp, :integer, 10]
      self[:weapon] = [:question_weapon, :weapon, :broad_sword]
      self[:armor] = [:question_armor, :armor, :no_armor]
      self[:move_capacity] = [:question_move_capacity, :integer, 10]
    end
  end

  class SkillHash < Hash
    def initialize
      self[:sing] = [:artistic, :active]
      self[:stalk] = [:subterfuge, :stealth]
      self[:pick_locks] = [:subterfuge, :mechanics]
    end
  end
  class ActionTable < Hash
    def initialize
      self[:failure] = [-1000, 3]
      self[:success] = [4, 1000]
    end
  end
end
