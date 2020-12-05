require "rpg-prompt/message.rb"
require "rpg-prompt/texts_prompt.rb"
require "rpg-prompt/keypress.rb"
require "rpg-prompt/save.rb"
require "rpg-prompt/rules_sheet.rb"

Settings_file_name = "./rpg-prompt.settings"
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
  $rules_file_name = "./rules_" + $system + ".rb"
  $hashes_file_name = "./rules_" + $system + "_hashes.rb"
  $texts_file_name = "./texts_" + $system + ".rb"
  unless (File.exist?($rules_file_name)) && (File.exist?($hashes_file_name)) && (File.exist?($texts_file_name))
    Message.message(:wrong_config)
    return -1
  end
else
  $rules_file_name = "rpg-prompt/rules_default.rb"
  $hashes_file_name = "rpg-prompt/rules_default_hashes.rb"
  $texts_file_name = "rpg-prompt/texts_default.rb"
end

require $rules_file_name
require $hashes_file_name
require $texts_file_name

module Rules
  class Combat < Hash
  end

  class Pool < Hash
  end
end

module ManageCommand
  class Command
    @@pool = Rules::Pool.new(nil)
    @@combat = Rules::Combat.new(nil)

    def initialize(command_symbol, line_array, options)
      @command_symbol = command_symbol
      @line_array = line_array
      @options = options
    end

    def command
      case @command_symbol
# *****************  case :quit  ***************** #
      when :quit_short
        :quit
      when :quit
        if @options.length != 1
          Message.message(:bad_quit)
          return_symbol = :bad_quit
        else @options.length == 1
          return_symbol = :quit
          case @options[0]
          when 's'
            Save.save_backup(@@pool)
          when 'q'
            Message.message(:quit_without_saving)
          end
        end
        return_symbol

# *****************  case :hits  ***************** #
      when :hits, :hits_short
        attacker_name = @line_array[0]
        defender_name = @line_array[2]
  
        if (@@combat[attacker_name]==nil)||(@@combat[defender_name]==nil)
          Message.message(:hits_unable)
          [attacker_name, defender_name].each do |name|
            if @@combat[name]==nil
              if @@pool.key?(name)
                Message.help(:not_in_combat, {short_name: @@pool[name].full_name})
              else
                Message.help(:does_not_exist, {short_name: name})
              end
            end
          end
          return_symbol = :hits_fail
        else
          attacker_sheet = @@pool[attacker_name]
          defender_sheet = @@pool[defender_name]
          attack = Rules::AttackTurn.new(attacker_sheet, defender_sheet)
          no_damage, modifier = attack.process_options(@options)
          if no_damage
            Message.help(:hits_check_mod, {modifier: modifier})
          else
            Message.help(:hits,
              {attacker_name: attacker_sheet.full_name,
               defender_name: defender_sheet.full_name})
            attack.resolve
          end
          return_symbol = no_damage ? :hits_no_damage : :hits
        end

# *****************  case :skill  ***************** #
      when :skill, :skill_short
        case @command_symbol
        when :skill
          short_name = @line_array[1]
        when :skill_short
          short_name = @line_array[0]
        end
        skill =  @line_array[2]
        command_mod = (@line_array.length == 4) ? @line_array[3].to_i : 0
        if @@pool[short_name].nil?
          Message.help(:not_loaded, {short_name: short_name})
        elsif Rules::ActionTurn.skill?(skill)
          Rules::ActionTurn.skill?(skill)
          action = Rules::ActionTurn.new(@@pool[short_name], skill)
          unless action == nil
            no_action, modifier = action.process_options(@options, command_mod)
            unless no_action
              puts action.resolve
            end
          end
        else
          Message.help(:skill_not_exists, {skill: skill})
        end

# *****************  case :skill_list  ***************** #
      when :skill_list
        skill_hash = RulesHashes::SkillHash.new
        skill_hash.each do |key, el|
          Message.help(:skill_puts, {skill_name: Message.skill_word(key)})
        end

# *****************  case :join  ***************** #
      when :skill_help, :skill_help_short
        skill = @line_array[1]
        if Rules::ActionTurn.skill?(skill)
          puts Message.skill_help(Message.skill_symbol(skill))
        else
          Message.help(:skill_not_exists, {skill: skill})
        end

# *****************  case :join  ***************** #
      when :join
        short_name = @line_array[1]
        if @@pool[short_name].nil?
          Message.help(:not_loaded, {short_name: short_name})
        elsif @@pool[short_name].unique?
          @@combat[short_name] = true
          @@pool[short_name][:warrior_in_combat] = true
          Message.help(:join_combat, {full_name: @@pool[short_name].full_name})
        else
          Message.help(:join_not_use_spawn, {short_name: short_name})
        end
        :join

# *****************  case :spawn  ***************** #
      when :spawn
        short_name = @line_array[1]
        number = @line_array[2]
        number = number.slice(1,4)
        n_spawn = number.to_i
        if @@pool[short_name].nil?
          Message.help(:not_loaded, {short_name: short_name})
        elsif @@pool[short_name].unique?
          Message.help(:spawn_not, {short_name: short_name})
        else
          if n_spawn > 100
            Message.message(:n_spawn_overload)
          else
            Message.help(:spawning, {n_spawn: n_spawn, short_name: short_name})
            (1..n_spawn).each do |i|
              short_name_foe = short_name + String(i)
              @@pool[short_name_foe] = Rules::Spawn.new(short_name_foe)
              @@pool[short_name_foe].clone_sheet(@@pool[short_name], short_name_foe)
              @@pool[short_name_foe][:spawned] = true
              @@pool[short_name_foe][:warrior_in_combat] = true
              @@combat[short_name_foe] = true
            end
          end
        end
        :spawn

# *****************  case :leave  ***************** #
      when :leave
        short_name = @line_array[1]
        if @@combat.key?(short_name)
          @@combat.delete(short_name)
          Message.help(:leave_combat, {short_name: short_name})
        else
          Message.help(:not_in_combat, {short_name: short_name})
        end
        :leave

# *****************  case :round  ***************** #
      when :round
        if @line_array.length == 1
          n_rounds = 1
        else
          n_rounds = Integer(@line_array[1])
        end
        (1..n_rounds).each do |i|
          @@combat.each do |short_name, ep|
            sheet = @@pool[short_name]
            sheet.pass_round
            @@combat.each do |short_name, ep|
              if @@pool[short_name].dead?
                Message.help(:dead_warrior, {full_name: @@pool[short_name].full_name})
                @@pool.delete(short_name)
                @@combat.delete(short_name)
              end
            end
          end
        end
        :round

# *****************  case :pool  ***************** #
      when :pool, :pool_short
        if @line_array.length == 1
          if @@pool.empty?
            Message.message(:empty_pool)
          else
            Message.pool_status(@@pool)
          end
        end
        :pool

# *****************  case :combat_status  ***************** #
      when :combat_status, :combat_status_short, :combat_status_short_verbose
        combat_status_flag = false
        short_name = nil
        short_name_flag = false
        if (@options.length > 0)
          verbose_flag = true
        else
          verbose_flag = (@command_symbol == :combat_status_short_verbose)
        end

        if @line_array.length == 1
          combat_status_flag = true
          short_name_flag = false
        elsif @line_array.length == 2
          combat_status_flag = false
          short_name = @line_array[1]
          short_name_flag = true
        else
          puts 743501
        end

        if combat_status_flag
          unless verbose_flag
            Message.combat_status(@@combat, @@pool)
          else
            Message.combat_status_verbose(@@combat, @@pool)
          end
        elsif short_name_flag
          unless verbose_flag
            Message.short_readable(@@pool[short_name])
          else
            Message.readable(@@pool[short_name])
          end
        else
          Message.help(:not_in_combat, {short_name: short_name})
        end
        :combat_status

# *****************  case :create  ***************** #
      when :create_character, :create_character_short,
           :create_foe, :create_foe_short,
           :create_spawn, :create_spawn_short
        case @command_symbol
        when :create_character, :create_character_short
          return_symbol = :create_character
          type = :character
        when :create_foe, :create_foe_short
          return_symbol = :create_foe
          type = :foe
        when :create_spawn, :create_spawn_short
          return_symbol = :create_spawn
          type = :spawn
        end
        short_name = @line_array.pop
        Message::Questionnaire.set_type(type)
        
        if @@pool.key?(short_name)
          Message.help(:already_loaded, {short_name: short_name})
          create_new = (Keypress.read_char == 'c')
        else
          create_new = true
        end
        if create_new
          @@pool[short_name] = case type
          when :character
            Rules::Character.new(short_name)
          when :foe
            Rules::Foe.new(short_name)
          when :spawn
            Rules::Spawn.new(short_name)
          end
          @@pool[short_name].create_new_w_questions
          @@pool[short_name][:type] = type
        end
        Message.help(:created_new, {short_name: short_name})
        return_symbol

# *****************  case :set_attribute  ***************** #
      when :set_attribute
        return_symbol = :set_attribute
        if (@@pool.key?(@line_array[1]))
          short_name = @line_array[1]
          full_name = @@pool[short_name].full_name
          attribute = @line_array[2].to_sym
          unless attribute == :short_name
            value = @line_array[3]
            return_symbol = @@pool[short_name].set_attribute(attribute, value)
          else
            return_symbol = :set_fail
          end
        end

        if return_symbol == :set_attribute
          Message.help(:setting_attribute, {full_name: full_name,
            attribute: attribute,
            value: value})
        elsif return_symbol == :set_fail
          Message.message(:cannot_set_short_name)
        end
        return_symbol

# *****************  case :save_warrior  ***************** #
      when :list_warriors
        Save.list_warriors
        :list_warriors

# *****************  case :save_warrior  ***************** #
      when :save_warrior, :save_warrior_short
        short_name = @line_array.pop

        if Save.save_exist?(short_name)
          Message.message(:save_file_exists_warn)
          if Keypress.read_char == "o"
            Message.message(:save_overwrite)
          else
            short_name = :no_overwrite
          end
        else
          Message.message(:save_saving)
        end

        if @@pool[short_name] != nil
          sheet = @@pool[short_name]
          if Save.save_sheet(short_name, sheet) == 0
            if sheet.unique?
              Message.help(:save_success_unique, {short_name: Message.help_string(:full_name, sheet)})
            elsif !(sheet.unique?)
              Message.help(:save_success_spawn, {short_name: Message.help_string(:full_name, sheet)})
            else
              puts 14321
            end
          else
            Message.message(:save_error)
          end
        elsif short_name == :no_overwrite
          Message.message(:cancel)
        else
          Message.help(:save_not_exist, {short_name: short_name})
        end
        :save_warrior

# *****************  case :load_warrior  ***************** #
      when :load_warrior, :load_warrior_short
        short_name = @line_array.pop
        sheet = @@pool[short_name]

        if (sheet != nil) && (@options.length == 0)
          Message::Questionnaire.set_type(sheet[:type])
          Message.load_prompt(:loaded, {full_name: Message.help_string(:full_name, sheet), spawn_name: short_name})
          if Keypress.read_char != "r"
            short_name = nil
          else
            @options[0] = "r"  # Enter the option manually
          end
        end
        if short_name != nil
          if (@options[0] == "r")
            Message::Questionnaire.set_type(sheet[:type])
            Message.load_prompt(:reloading, {full_name: Message.help_string(:full_name, sheet), spawn_name: short_name})
          else
            Message.message(:load_loading)
          end
          sheet = Save.load_sheet(short_name)
          if sheet
            @@pool[short_name] = sheet
            Message::Questionnaire.set_type(sheet[:type])
            Message.load_prompt(:welcome, {full_name: Message.help_string(:full_name, sheet), spawn_name: short_name})
          elsif sheet == false
            Message.help(:load_fail, {short_name: short_name})
          elsif sheet == nil
            Message.help(:load_not_exist, {short_name: short_name})
          end
        else
          Message.message(:load_aborted)
        end
        :load_warrior

# *****************  case :delete_warrior  ***************** #
      when :delete_warrior, :delete_warrior_short
        short_name = @line_array.pop

        Message.help(:delete_warrior_warn, {short_name: short_name})
        if Keypress.read_char == "y"
          Message.help(:delete_warrior, {short_name: short_name})
          s = Save.delete_sheet(short_name)
          if s == -1
            Message.message(:file_not_found)
          end
        else
          Message.message(:cancel)
        end
        :delete_warrior

# *****************  case :list_scenes  ***************** #
      when :list_scenes
        Save.list_scenes
        :list_scenes

# *****************  case :save_scene  ***************** #
      when :save_scene, :save_scene_short
        short_name = @line_array.pop

        if Save.save_exist?(short_name)
          Message.message(:save_file_exists_warn)
          if Keypress.read_char == "o"
            Message.message(:save_overwrite)
          else
            short_name = :no_overwrite
          end
        else
          Message.message(:save_saving)
        end

        unless short_name == :no_overwrite
          s = Save.save_scene(@@pool, short_name)
          if s == 0
            Message.message(:save_scene)
          else
            Message.message(:save_error)
          end
        else
          Message.message(:cancel)
        end
        :save_scene

# *****************  case :load_scene  ***************** #
      when :load_scene, :load_scene_short
        short_name = @line_array.pop
        pool_temp = Hash.new(nil)
        pool_temp= Save.load_scene(short_name)
        pool_temp.each do |short_name, sheet|
          @@pool[short_name] = pool_temp[short_name]
          if sheet[:warrior_in_combat]
            @@combat[short_name] = true
          end
        end
        :load_scene

# *****************  case :delete_scene  ***************** #
      when :delete_scene, :delete_scene_short
        short_name = @line_array.pop

        Message.help(:delete_scene_warn, {short_name: short_name})
        if Keypress.read_char == "y"
          Message.help(:delete_scene, {short_name: short_name})
          s = Save.delete_scene(short_name)
          if s == -1
            Message.message(:file_not_found)
          end
        else
          Message.message(:cancel)
        end
        :delete_scene

# *****************  case :free  ***************** #
      when :free
        short_name = @line_array[1]
        if @@pool[short_name]
          Message.help(:free_pool, {full_name: @@pool[short_name].full_name})
          @@pool.delete(short_name)
          @@combat.delete(short_name)
        else
          Message.help(:not_loaded, {short_name: short_name})
        end
        :free

# *****************  case :free_all  ***************** #
      when :free_all
        Message.message(:free_all_warn)
        if Keypress.read_char == "y"
          Message.message(:start_clean)
          @@pool = Hash.new(nil)
          @@combat = Hash.new(nil)
        else
          Message.message(:cancel)
        end
        :free_all

# *****************  case :quick_backup  ***************** #
      when :quick_backup
        Save.save_backup(@@pool)
        :quick_backup

# *****************  case :restore_backup  ***************** #
      when :restore_backup
        @@pool = Save.load_backup
        @@combat = Hash.new(nil)
        @@pool.each do |short_name, sheet|
          if sheet[:warrior_in_combat]
            @@combat[short_name] = true
          end
        end
        :restore_backup

# *****************  case :delete_backup  ***************** #
      when :delete_backup
        Message.message(:delete_backup_warn)
        if Keypress.read_char == "y"
          Message.message(:delete_backup)
          Save.delete_backup
        else
          Message.message(:cancel)
        end
        :delete_backup

# *****************  case :help  ***************** #
      when :help
        Message.print_help
        :help

# *****************  case :help  ***************** #
      when :example
        Message.print_example
        :example

# *****************  case :undo  ***************** #
      when :undo
        Message.message(:confirm_undo)
        c = Keypress.read_char
        if c == 's'
          @@pool = Save.load_pool
        end
        :undo

# *****************  case :test  ***************** #
      when :test
        :test

# *****************  case :empty  ***************** #
      when :empty
        :empty

# *****************  case :clone  ***************** #
      when :clone
        system = @line_array[2]
        prefix = Gem.datadir("rpg-prompt")
        FileUtils.cp(prefix + "/rules_default.rb", "./rules_" + system + ".rb")
        FileUtils.cp(prefix + "/rules_default_hashes.rb", "./rules_" + system + "_hashes.rb")
        FileUtils.cp(prefix + "/texts_default.rb", "./texts_" + system + ".rb")
        filename = "./rpg-prompt.settings"
        filehandler = File.open(filename, "w")
        filehandler.write("language: english\n")
        filehandler.write("system: " + system + "\n")
        filehandler.close

# *****************  case :else  ***************** #
      else
        Message.message(:unknown_command)
        :unknown_command
      end
    end
  end
end
