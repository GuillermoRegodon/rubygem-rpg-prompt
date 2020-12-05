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


  Message::Dictionary.language = :english
  @@skill_dict.add_word(:sing, "sings")
  @@skill_dict.add_word(:stalk, "stalks")
  @@skill_dict.add_word(:pick_locks, "pick_locks")


  Message::Dictionary.language = :spanish
  @@skill_dict.add_word(:sing, "canta")
  @@skill_dict.add_word(:stalk, "acecha")
  @@skill_dict.add_word(:pick_locks, "fuerza_cerradura")


# *****************  skill_dict  ***************** #
  valid_languages = [:english, :spanish]

  Message::Dictionary.language = :english
  @@skill_help_hash.add_word(:sing,
    "-10: if the language of the song is unknown (competence 4 or less)")
  @@skill_help_hash.add_word(:stalk,
"""Crawl (i.e., 0.25 x Base) +10
Creep (i.e., 0.5 x Base) +0
Walk -10
Jog -25
Run -50
Sprint -75""")
  @@skill_help_hash.add_word(:pick_locks,
"""Successful Lock Lore maneuver prior to attempt +40
Each time picking lock has been unsuccessfully attempted -30
Have picked this specific lock before +50
Have picked this type of lock before +25
Have description of mechanism +10""")

  
  Message::Dictionary.language = :spanish
  @@skill_help_hash.add_word(:sing,
    "-10: si no se conoce el idioma (competencia 4 o menos)")
    @@skill_help_hash.add_word(:stalk,
"""Arrastrarse (i.e., 0.25 x Base) +10
Agacharse (i.e., 0.5 x Base) +0
Caminar -10
Trotar -25
Correr -50
Esprintar -75""")
  @@skill_help_hash.add_word(:pick_locks,
"""Éxito en una tirada de Conocimientode cerraduras +40
Por cada intento posterior -30
Haber forzado la misma cerradura +50
Haber forzado el mismo tipo de cerradura +25
Disponer de una descripción +10""")
    
        
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
  @@questionnaire_dict.add_word(:question_ws,
    "Enter the weapon skill")
  @@questionnaire_dict.add_word(:question_armor,
    "What armor does the character use?")
  @@questionnaire_dict.add_word(:question_greaves,
    "Are greaves being used?")
  @@questionnaire_dict.add_word(:question_bracelet,
    "Are bracelets being used?")
  @@questionnaire_dict.add_word(:question_helmet,
    "Is a helmet being used?")
  @@questionnaire_dict.add_word(:question_shield,
    "Is a shield being used?")
  @@questionnaire_dict.add_word(:question_db,
    "What the defensive bonus (including the shield)?")
  @@questionnaire_dict.add_word(:question_move_capacity,
    "What is the movement capacity?")
  @@questionnaire_dict.add_word(:question_constitution,
    "What is the constitution?")

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
  @@questionnaire_dict.add_word(:question_ws,
    "Enter the weapon skill")
  @@questionnaire_dict.add_word(:question_armor,
    "What armor does the foe use?")
  @@questionnaire_dict.add_word(:question_greaves,
    "Are greaves being used?")
  @@questionnaire_dict.add_word(:question_bracelet,
    "Are bracelets being used?")
  @@questionnaire_dict.add_word(:question_helmet,
    "Is a helmet being used?")
  @@questionnaire_dict.add_word(:question_shield,
    "Is a shield being used?")
  @@questionnaire_dict.add_word(:question_db,
    "What the defensive bonus (including the shield)?")
  @@questionnaire_dict.add_word(:question_move_capacity,
    "What is the movement capacity?")
  @@questionnaire_dict.add_word(:question_constitution,
    "What is the constitution?")

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
  @@questionnaire_dict.add_word(:question_ws,
    "Enter the weapon skill")
  @@questionnaire_dict.add_word(:question_armor,
    "What armor does this kind of enemy use?")
  @@questionnaire_dict.add_word(:question_greaves,
    "Are greaves being used?")
  @@questionnaire_dict.add_word(:question_bracelet,
    "Are bracelets being used?")
  @@questionnaire_dict.add_word(:question_helmet,
    "Is a helmet being used?")
  @@questionnaire_dict.add_word(:question_shield,
    "Is a shield being used?")
  @@questionnaire_dict.add_word(:question_db,
    "What the defensive bonus (including the shield)?")
  @@questionnaire_dict.add_word(:question_move_capacity,
    "What is the movement capacity?")
  @@questionnaire_dict.add_word(:question_constitution,
    "What is the constitution?")
  
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
  @@questionnaire_dict.add_word(:question_ws,
    "Introduce su bonificación ofensiva")
  @@questionnaire_dict.add_word(:question_armor,
    "¿Qué tipo de armadura utiliza?")
  @@questionnaire_dict.add_word(:question_greaves,
    "¿Lleva pernales?")
  @@questionnaire_dict.add_word(:question_bracelet,
    "¿Lleva brazales?")
  @@questionnaire_dict.add_word(:question_helmet,
    "¿Lleva casco?")
  @@questionnaire_dict.add_word(:question_shield,
    "¿Usa escudo?")
  @@questionnaire_dict.add_word(:question_db,
    "¿Cuál es su bonificación defensiva, (incluyendo el escudo)?")
  @@questionnaire_dict.add_word(:question_move_capacity,
    "¿Cuál es su capacidad de movimiento?")
  @@questionnaire_dict.add_word(:question_constitution,
    "¿Cuál es su constitución?")

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
  @@questionnaire_dict.add_word(:question_ws,
    "Introduce su bonificación ofensiva")
  @@questionnaire_dict.add_word(:question_armor,
    "¿Qué tipo de armadura utiliza?")
  @@questionnaire_dict.add_word(:question_greaves,
    "¿Lleva pernales?")
  @@questionnaire_dict.add_word(:question_bracelet,
    "¿Lleva brazales?")
  @@questionnaire_dict.add_word(:question_helmet,
    "¿Lleva casco?")
  @@questionnaire_dict.add_word(:question_shield,
    "¿Usa escudo?")
  @@questionnaire_dict.add_word(:question_db,
    "¿Cuál es su bonificación defensiva, (incluyendo el escudo)?")
  @@questionnaire_dict.add_word(:question_move_capacity,
    "¿Cuál es su capacidad de movimiento?")
  @@questionnaire_dict.add_word(:question_constitution,
    "¿Cuál es su constitución?")

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
  @@questionnaire_dict.add_word(:question_ws,
    "Introduce su bonificación ofensiva")
  @@questionnaire_dict.add_word(:question_armor,
    "¿Qué tipo de armadura utilizan?")
  @@questionnaire_dict.add_word(:question_greaves,
    "¿Llevan pernales?")
  @@questionnaire_dict.add_word(:question_bracelet,
    "¿Llevan brazales?")
  @@questionnaire_dict.add_word(:question_helmet,
    "¿Llevan casco?")
  @@questionnaire_dict.add_word(:question_shield,
    "¿Usan escudo?")
  @@questionnaire_dict.add_word(:question_db,
    "¿Cuál es su bonificación defensiva, (incluyendo el escudo)?")
  @@questionnaire_dict.add_word(:question_move_capacity,
    "¿Cuál es su capacidad de movimiento?")
  @@questionnaire_dict.add_word(:question_constitution,
    "¿Cuál es su constitución?")
    
end