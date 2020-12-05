# In this file, you may define the messages that the prompt returns in
# each step in the resolution of attacks and actions.
#
# I have included the options of changing the language, a concession to
# my Spanish friends. More languages could be included
#
# There are several types of messages:
#
#   - Message.message(:sym). Messages that are always put with the same words
#     E.g. Message.message(:greeting). It will put the greeting in the given
#     language.
#
#   - Message.help(.sym, hash). Message that include variable words, that are
#     handled with the format string % syntax.
#     E.g. Message.help(:hits_lose_hp, {:full_name => "Jack", :damage => 3})
#
#   - Diccionaries. Translation between the symbol and the string. It is
#     performed with custom methods to allows the use of other languages
#     and longer strings with spaces. There are diccionaries for weapons
#     E.g. Message.weapon_word(:sym) and Message.weapon_symbol("weapon")
#     For weapons
#     E.g. Message.weapon_word(:sym) and Message.weapon_symbol("weapon")
#     For armors
#     E.g. Message.armor_word(:sym) and Message.armor_symbol("armor")
#     For skills
#     E.g. Message.skill_word(:sym) and Message.skill_symbol("skill")
#
#   - Skill Help is another Diccionary, but woth longer answers. It is not
#     used for lists, but it should match the keys of the skill Diccionary
#
#   - Questionnaire is a modified diccionary, because it is used in the
#     the creation of characters, but from this module, it makes no difference.
#     You do not have to use it, but the questions should be well defined here.
#     Any question that matches it Hash in RulesHashes are included in the
#     creation of characters. Yoy may make questions for the three type of
#     warriors, :character, :foe and :spawn
#
# In practice, Message.message for messages that only differentiate language,
# Message.help for messages that differentiate language and have format inputs,
# Message, and Questionnaire for message that differentiate language and warrior
# type (Character, Foe or Spawn)
#
# You may add new words to these diccionariesusing
#   - Message.add_weapon(:sym, "weapon")...
#
# You may also add a new diccionary using this structure:
#
# module Message
#   def self.add_newdicc(s, w)
#     @@newdicc_dict.add_word(s, w)
#   end

#   def self.newdicc_word(s)
#     @@newdicc_dict.word(s)
#   end

#   def self.newdicc_symbol(w)
#     @@newdicc_dict.symbol(w)
#   end
# end
#
# Add the words using Message.add_newdicc(:sym, "word")
# and use it using Message.newdicc_word(:sym) or Message.newdicc_symbol("word")
#

module Message
# *****************  message_dict  ***************** #  
  valid_languages = [:english, :spanish]

  Message::Dictionary.language = :english
  @@message_dict.add_word(:greeting,
    "Welcome to the RPG Combat Assistant, by Guillermo Regodon")
  @@message_dict.add_word(:goodbye, 
    "Leaving the RPG Combat Assistant")

  @@message_dict.add_word(:ask_for_d6,
    "Enter the roll (between 1 and 6)")
  @@message_dict.add_word(:ask_for_d10,
    "Enter the roll (between 1 and 10)")


  Message::Dictionary.language = :spanish
  @@message_dict.add_word(:greeting,
    "Bienvenido al asistente de combate para juegos de rol, por Guillermo Regodón.")
  @@message_dict.add_word(:goodbye, 
    "Abandonando el asistente de combate para juegos de rol.")

  @@message_dict.add_word(:ask_for_d6,
    "Introduce la tirada (entre 1 y 6)")
  @@message_dict.add_word(:ask_for_d10,
    "Introduce la tirada (entre 1 y 10)")




# *****************  help_dict  ***************** #
valid_languages = [:english, :spanish]

Message::Dictionary.language = :english
@@help_dict.add_word(:rolling, "Dice rolling... ¡%{roll}!")
@@help_dict.add_word(:hits_lose_hp, "¡%{full_name} loses %{damage} hp!")
@@help_dict.add_word(:dead_in, "¡dies in %{el} t!")
@@help_dict.add_word(:attack_roll,
  "   Mod Roll = %{r} = Roll(%{roll}) + Mod(%{modifier})")
@@help_dict.add_word(:skill_roll,
  "   Mod Roll = %{r} = Roll(%{roll}) + Mod(%{modifier})")




Message::Dictionary.language = :spanish
@@help_dict.add_word(:rolling, "Se lanzan los dados... ¡%{roll}!")
@@help_dict.add_word(:hits_lose_hp, "¡%{full_name} pierde %{damage} hp!")
@@help_dict.add_word(:dead_in, "¡muere en %{el} t!")
@@help_dict.add_word(:attack_roll,
  "   Mod Roll = %{r} = Roll(%{roll}) + Mod(%{modifier})")
@@help_dict.add_word(:skill_roll,
  "   Mod Roll = %{r} = Roll(%{roll}) + Mod(%{modifier})")




# *****************  weapon_dict  ***************** #  
valid_languages = [:english, :spanish]

Message::Dictionary.language = :english
@@weapon_dict.add_word(:broad_sword, "broad sword")
@@weapon_dict.add_word(:dagger, "dagger")
@@weapon_dict.add_word(:scimitar, "scimitar")
@@weapon_dict.add_word(:hand_axe, "hand axe")
@@weapon_dict.add_word(:composite_bow, "composite bow")
@@weapon_dict.add_word(:mace, "mace")
@@weapon_dict.add_word(:warhammer, "warhammer")
@@weapon_dict.add_word(:battle_axe, "battle axe")
@@weapon_dict.add_word(:claw_and_bite, "claws and teeth")

Message::Dictionary.language = :spanish
@@weapon_dict.add_word(:broad_sword, "espada ancha")
@@weapon_dict.add_word(:dagger, "daga")
@@weapon_dict.add_word(:scimitar, "cimitarra")
@@weapon_dict.add_word(:hand_axe, "hacha de mano")
@@weapon_dict.add_word(:composite_bow, "arco compuesto")
@@weapon_dict.add_word(:mace, "maza")
@@weapon_dict.add_word(:warhammer, "martillo de guerra")
@@weapon_dict.add_word(:battle_axe, "hacha de batalla")
@@weapon_dict.add_word(:claw_and_bite, "garras y mordiscos")

# *****************  armor_dict  ***************** #  
valid_languages = [:english, :spanish]

Message::Dictionary.language = :english
@@armor_dict.add_word(:no_armor, "no armor")
@@armor_dict.add_word(:hardened_leather, "hardened leather")
@@armor_dict.add_word(:chainmail, "chainmail")
@@armor_dict.add_word(:plate, "plate")

Message::Dictionary.language = :spanish
@@armor_dict.add_word(:no_armor, "sin armadura")
@@armor_dict.add_word(:hardened_leather, "cuero endurecido")
@@armor_dict.add_word(:chainmail, "cota de malla")
@@armor_dict.add_word(:plate, "placas")

# *****************  skill_dict  ***************** #
valid_languages = [:english, :spanish]

Message::Dictionary.language = :english
@@skill_dict.add_word(:failure, "Failure, try again another day")
@@skill_dict.add_word(:success, "Success, 100%")


Message::Dictionary.language = :spanish
@@skill_dict.add_word(:failure, "Fallo, intentalo otra vez otro día")
@@skill_dict.add_word(:success, "Éxito, 100%")


# Note: in this diccionary, spaces should not be used
Message::Dictionary.language = :english
@@skill_dict.add_word(:sing, "sings")
@@skill_dict.add_word(:stalk, "stalks")
@@skill_dict.add_word(:pick_locks, "pick_locks")


# Note: in this diccionary, spaces should not be used
Message::Dictionary.language = :spanish
@@skill_dict.add_word(:sing, "canta")
@@skill_dict.add_word(:stalk, "acecha")
@@skill_dict.add_word(:pick_locks, "fuerza_cerradura")


# *****************  skill_help_hash  ***************** #
valid_languages = [:english, :spanish]

Message::Dictionary.language = :english
@@skill_help_hash.add_word(:sing,
  "Sings to entice the public and lift up their hearts")
@@skill_help_hash.add_word(:stalk,
  "Approaches somebody or somewhere without being seen or heard")
@@skill_help_hash.add_word(:pick_locks,
  "Opens a lock using appropriate tools")


Message::Dictionary.language = :spanish
@@skill_help_hash.add_word(:sing,
  "Canta para seducir al public y elevar sus animos")
  @@skill_help_hash.add_word(:stalk,
  "Se acerca sigilosamente a alguien o algo sin ser visto u oido")
@@skill_help_hash.add_word(:pick_locks,
  "Abre una cerradura usando material apropriado")
  
      
# *****************  questionnaire_dict  ***************** #
valid_languages = [:english, :spanish]
valid_types = [:character, :foe, :spawn]

Message::Questionnaire.set_option(:english, :character)
@@questionnaire_dict.add_word(:question_full_name, "Full name of Character?")
@@questionnaire_dict.add_word(:question_nickname,
  "Enter the character's nickname")
@@questionnaire_dict.add_word(:question_race,
  "Enter the character's race")
@@questionnaire_dict.add_word(:question_hp,
  "Enter the character's health points")
@@questionnaire_dict.add_word(:question_weapon,
  "What weapon does the character use?")
@@questionnaire_dict.add_word(:question_armor,
  "What armor does the character use?")
@@questionnaire_dict.add_word(:question_move_capacity,
  "What is the movement capacity?")

Message::Questionnaire.set_option(:english, :foe)
@@questionnaire_dict.add_word(:question_full_name, "Full name of Foe?")
@@questionnaire_dict.add_word(:question_nickname,
  "Enter the foe's nickname")
@@questionnaire_dict.add_word(:question_race,
  "Enter the foe's race")
@@questionnaire_dict.add_word(:question_hp,
  "Enter the foe's health points")
@@questionnaire_dict.add_word(:question_weapon,
  "What weapon does the foe use?")
@@questionnaire_dict.add_word(:question_armor,
  "What armor does the foe use?")
@@questionnaire_dict.add_word(:question_move_capacity,
  "What is the movement capacity?")

Message::Questionnaire.set_option(:english, :spawn)
@@questionnaire_dict.add_word(:question_full_name,
  """Enter names for this kind of enemy, recomended 10 or more,
\"q\" to finish. Enter only the race if it is an enemy without name.""")
@@questionnaire_dict.add_word(:question_nickname,
  """Enter nicknames for this kind of enemy, recomended 10 or more,
\"q\" to finish.""")
@@questionnaire_dict.add_word(:question_race,
  "Enter this kind of enemy's race")
@@questionnaire_dict.add_word(:question_hp,
  "Enter this kind of enemy's health points")
@@questionnaire_dict.add_word(:question_weapon,
  "What weapon does this kind of enemy use?")
@@questionnaire_dict.add_word(:question_armor,
  "What armor does this kind of enemy use?")
@@questionnaire_dict.add_word(:question_move_capacity,
  "What is the movement capacity?")

Message::Questionnaire.set_option(:spanish, :character)
@@questionnaire_dict.add_word(:question_full_name,
  "Introduce el nombre completo del personaje")
@@questionnaire_dict.add_word(:question_nickname,
  "Introduce el apodo del personaje")
@@questionnaire_dict.add_word(:question_race,
  "Introduce la raza del personaje")
@@questionnaire_dict.add_word(:question_hp,
  "Introduce los puntos de vida del personaje")
@@questionnaire_dict.add_word(:question_weapon,
  "¿Qué arma utiliza?")
@@questionnaire_dict.add_word(:question_armor,
  "¿Qué tipo de armadura utiliza?")
@@questionnaire_dict.add_word(:question_move_capacity,
  "¿Cuál es su capacidad de movimiento?")

Message::Questionnaire.set_option(:spanish, :foe)
@@questionnaire_dict.add_word(:question_full_name,
  "Introduce el nombre completo del enemigo")
@@questionnaire_dict.add_word(:question_nickname,
  "Introduce el apodo del enemigo")
@@questionnaire_dict.add_word(:question_race,
  "Introduce la raza del enemigo")
@@questionnaire_dict.add_word(:question_hp,
  "Introduce los puntos de vida del enemigo")
@@questionnaire_dict.add_word(:question_weapon,
  "¿Qué arma utiliza?")
@@questionnaire_dict.add_word(:question_armor,
  "¿Qué tipo de armadura utiliza?")
@@questionnaire_dict.add_word(:question_move_capacity,
  "¿Cuál es su capacidad de movimiento?")

Message::Questionnaire.set_option(:spanish, :spawn)
@@questionnaire_dict.add_word(:question_full_name,
  """Introduce nombres para este tipo de enemigo, recomendado 10 o más,
\"q\" para terminar. Introduce solo la raza si es un enemigo sin nombre.""")
@@questionnaire_dict.add_word(:question_nickname,
  """Introduce apodos para este tipo de enemigo, recomendado 10 o más,
\"q\" para terminar.""")
@@questionnaire_dict.add_word(:question_race,
  "Introduce la raza de este tipo de enemigo")
@@questionnaire_dict.add_word(:question_hp,
  "Introduce los puntos de vida de este tipo de enemigo")
@@questionnaire_dict.add_word(:question_weapon,
  "¿Qué arma utilizan?")
@@questionnaire_dict.add_word(:question_armor,
  "¿Qué tipo de armadura utilizan?")
@@questionnaire_dict.add_word(:question_move_capacity,
  "¿Cuál es su capacidad de movimiento?")
  
end