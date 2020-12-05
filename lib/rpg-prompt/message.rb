module Message
  class Language
    @@language = nil

    def initialize(valid_languages)
      @@Valid_Languages = valid_languages.clone
      if @@language.nil?
        @@language = @@Valid_Languages[0]
      end
    end
  end

  class Dictionary < Language
    @@language = nil

    def initialize(valid_languages)
      @dict_hash = Hash.new("no lang")
      super(valid_languages)
      @@Valid_Languages.each do |l|
        @dict_hash[l] = Hash.new("no word")
      end
    end

    def self.language=(l)
      unless @@Valid_Languages.nil?
        if @@Valid_Languages.include?(l)
          @@language = l
          Questionnaire.set_option(l, Questionnaire.type)
        end
      end
    end

    def add_word(s, w)
      @dict_hash[@@language][s] = w
    end

    def word(s)
      @dict_hash[@@language][s]
    end

    def symbol(w)
      @dict_hash[@@language].key(w)
    end
  end
  
  valid_languages = [:english, :spanish]

  @@message_dict = Message::Dictionary.new(valid_languages)
  @@help_dict = Message::Dictionary.new(valid_languages)
  @@weapon_dict = Message::Dictionary.new(valid_languages)
  @@armor_dict = Message::Dictionary.new(valid_languages)
  @@skill_dict = Message::Dictionary.new(valid_languages)
  @@skill_help_hash = Message::Dictionary.new(valid_languages)

  class Option < Language
    @@option = nil
    @@valid_options = nil

    def initialize(valid_languages, valid_types)
      super(valid_languages)
      @@Valid_Types = valid_types.clone
      if @@valid_options.nil?
        @@valid_options = Array.new
      end
      @@Valid_Languages.each do |l|
        @@Valid_Types.each do |t|
          @@valid_options.push([l, t])
        end
      end
      if @@option.nil?
        @@option = @@valid_options[0]
      end
    end
  end

  class Questionnaire < Option
    def initialize(valid_languages, valid_types)
      @dict_hash = Hash.new("no lang")
      super(valid_languages, valid_types)
      @@valid_options.each do |l|
        @dict_hash[l] = Hash.new("no word")
      end
    end

    def self.set_option(l, t)
      unless @@valid_options.nil?
        if @@valid_options.include?([l,t])
          @@option = [l, t]
          @@language = l
        end
      end
    end

    def self.set_type(t)
      unless @@valid_options.nil?
        if @@valid_options.include?([@@language,t])
          @@option = [@@language, t]
        end
      end
    end

    def add_word(s, w)
      @dict_hash[@@option][s] = w
    end

    def word(s)
      @dict_hash[@@option][s]
    end

    def self.type
      unless @@option.nil?
        @@option[1]
      else
        nil
      end
    end
  end

  valid_languages = [:english, :spanish]
  valid_types = [:character, :foe, :spawn]

  @@questionnaire_dict = Message::Questionnaire.new(valid_languages, valid_types)
  @@load_prompt_dict = Message::Questionnaire.new(valid_languages, valid_types)

# *****************  message_dict  ***************** #  
  def self.add_message(s, m)
    @@message_dict.add_word(s, m)
  end
  
  def self.message(s)
    puts @@message_dict.word(s)
  end

# *****************  help_dict  ***************** #
  def self.add_help(s, h)
    @@help_dict.add_word(s, h)
  end
  
  def self.help(s, arg)
    puts @@help_dict.word(s) % arg
  end

  def self.help_string(s, arg)
    @@help_dict.word(s) % arg
  end

  def self.print_help
    data_dir = Gem.datadir("rpg-prompt")
    data_dir = data_dir ? data_dir : ""
    @@Help_file_name = data_dir + "/help.txt"
    puts open(@@Help_file_name).read
  end
  
  def self.print_example
    data_dir = Gem.datadir("rpg-prompt")
    data_dir = data_dir ? data_dir : ""
    @@Example_file_name = data_dir + "/example.txt"
    puts open(@@Example_file_name).read
  end

# *****************  weapon_dict  ***************** #  
  def self.add_weapon(s, w)
    @@weapon_dict.add_word(s, w)
  end

  def self.weapon_word(s)
    @@weapon_dict.word(s)
  end

  def self.weapon_symbol(w)
    @@weapon_dict.symbol(w)
  end

# *****************  armor_dict  ***************** #  
  def self.add_armor(s, w)
    @@armor_dict.add_word(s, w)
  end

  def self.armor_word(s)
    @@armor_dict.word(s)
  end

  def self.armor_symbol(w)
    @@armor_dict.symbol(w)
  end

# *****************  skill_dict  ***************** #
  def self.add_skill(s, w)
    @@skill_dict.add_word(s, w)
  end

  def self.skill_word(s)
    @@skill_dict.word(s)
  end

  def self.skill_symbol(w)
    @@skill_dict.symbol(w)
  end

  def self.skill_help(s)
    @@skill_help_hash.word(s)
  end

# *****************  questionnaire_dict  ***************** #
  def self.add_question(s, q)
    @@questionnaire_dict.add_word(s, w)
  end

  def self.question(s)
    puts @@questionnaire_dict.word(s)
  end

  def self.question_symbol(w)
    @@questionnaire_dict.symbol(w)
  end

# *****************  load_prompt_dict  ***************** #
  def self.add_load_prompt(s, q)
    @@load_prompt_dict.add_word(s, w)
  end

  def self.load_prompt(s, arg)
    puts @@load_prompt_dict.word(s) % arg
  end

# *****************  lists  ***************** #
  def self.puts_weapons_list(weapons_available)
    s = ""
    (0...weapons_available.length).each do |i|
      s += Message.weapon_word(weapons_available[i]) + " / "
      if (((i+1)%5) == 0) || (i == (weapons_available.length-1))
        puts s
        s = ""
      end
    end
  end

  def self.puts_armors_list(armors_available)
    s = ""
    (0...armors_available.length).each do |i|
      s += Message.armor_word(armors_available[i]) + " / "
    end
    puts s
  end

# *****************  status and readable  ***************** #
  def self.pool_status(pool)
    pool.each do |name, sheet|
      if not(sheet.spawned?)
        if sheet[:type] != :spawn
          Message.help(:warrior_in_one_line, sheet)
        else
          Message.help(:spawn_in_one_line, sheet)
        end
      end
    end
  end

  def self.combat_status(combat, pool)
    combat.each do |name, ep|
      sheet = pool[name]
      Message.short_readable(sheet)
    end
  end

  def self.combat_status_verbose(combat, pool)
    combat.each do |name, ep|
      sheet = pool[name]
      if (sheet.unique?) || (sheet.spawned?)
        Message.help(:full_name, sheet)
        Message.readable(sheet)
      end
    end
  end

  def self.short_readable(sheet)
    puts Message.help_string(:warrior_in_one_line_hp, sheet)
  end

  def self.readable(sheet)
    s = sheet.to_s
    s = s.gsub(", ","\n")
    s = s.gsub("=>\"","=>")
    s = s.gsub("=>","=> ")
    s = s.gsub("\""," ")
    s = s.gsub("{","")
    s = s.gsub("}","")
    puts s + "\n\n"
  end

  def self.load_language(lang)
    file_name = ".#{lang}.csv"
  end
end
