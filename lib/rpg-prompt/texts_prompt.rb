module Message
# *****************  message_dict  ***************** #  
  valid_languages = [:english, :spanish]

  Message::Dictionary.language = :english
  @@message_dict.add_word(:wrong_config,
    "Rules files not properly named")
  @@message_dict.add_word(:bad_quit,
    "\"quit\" requires an option: either -s to save and quit, or -q to quit without saving")
  @@message_dict.add_word(:unknown_command,
    "Unknown command, type \"help\" for helping information")
  @@message_dict.add_word(:empty_pool, 
    """There are no loaded warriors. Use \"load\" to load them o use
\"createchar\" (\"cc\"), \"createfoe\" (\"cf\") or \"createspawn\" (\"cs\")
to create a new warrior.""")
  @@message_dict.add_word(:save_file_exists_warn,
    "The file already exists, press \"o\" to overwrite it.")
  @@message_dict.add_word(:save_overwrite, "Overwriting...")
  @@message_dict.add_word(:save_saving, "Saving...")
  @@message_dict.add_word(:save_error, "Could not save.")
  @@message_dict.add_word(:save_scene, "Scene saved.")
  @@message_dict.add_word(:cancel, "Cancelling...")
  @@message_dict.add_word(:load_loading, "Loading...")
  @@message_dict.add_word(:load_aborted, "Load aborted.")
  @@message_dict.add_word(:confirm_undo,
    "Are you sure to undo the last command? \"s\" to confirm.")
  @@message_dict.add_word(:n_spawn_overload, "It is not possible to spawn that many!")
  @@message_dict.add_word(:hits_unable, "Could not complete the attack.")
  @@message_dict.add_word(:cannot_set_short_name, "Key cannot be changed.")
  @@message_dict.add_word(:preset_roll_prompt, 
    "Press \'r\' to enter a roll or any other key for a random roll.")
  @@message_dict.add_word(:bad_range, "Out of range.")
  @@message_dict.add_word(:hits_success, "The attack succeeds!")
  @@message_dict.add_word(:hits_fail, "The attack fails...")
  @@message_dict.add_word(:quit_without_saving, "Quit without saving.")
  @@message_dict.add_word(:free_all_warn, "Freeing all the warriors, press \"y\" to continue.")
  @@message_dict.add_word(:start_clean, "Freeing all the warriors.")
  @@message_dict.add_word(:delete_backup_warn, "Deleting backup, press \"y\" to continue.")
  @@message_dict.add_word(:delete_backup, "Deleting backup.")
  @@message_dict.add_word(:file_not_found, "Could no find the file")
  @@message_dict.add_word(:mortal_wound_hp, "     HP Exhausting hit!")
  @@message_dict.add_word(:mortal_wound_dead_in, "     Mortal wound!")


  Message::Dictionary.language = :spanish
  @@message_dict.add_word(:wrong_config,
    "Los ficheros de reglas no tienen los nombres correctos")
  @@message_dict.add_word(:bad_quit,
    "\"quit\" requiere una opción: -s para salvar y salir, o -q para salir sin guardar")
  @@message_dict.add_word(:unknown_command, 
    "Comando desconocido, escribe \"help\" para obtener ayuda.")
  @@message_dict.add_word(:empty_pool, 
    """No hay guerreros cargados. Utiliza \"load\" para cargarlos o utiliza
\"createchar\" (\"cc\"), \"createfoe\" (\"cf\") o \"createspawn\" (\"cs\")
para crear un guerrero nuevo.""")
  @@message_dict.add_word(:save_file_exists_warn,
    "El fichero ya existe, pulsa \"o\" para sobreescribir.")
  @@message_dict.add_word(:save_overwrite, "Sobreescribiendo...")
  @@message_dict.add_word(:save_saving, "Guardando...")
  @@message_dict.add_word(:save_error, "No se pudo guardar.")
  @@message_dict.add_word(:save_scene, "Escena guardada.")
  @@message_dict.add_word(:cancel, "Cancelando...")
  @@message_dict.add_word(:load_loading, "Cargando...")
  @@message_dict.add_word(:load_aborted, "Carga abortada.")
  @@message_dict.add_word(:confirm_undo,
    "¿Seguro que quieres deshacer el último comando? \'s\' para confirmar")
  @@message_dict.add_word(:n_spawn_overload, "¡No es posible generar tantos!")
  @@message_dict.add_word(:hits_unable, "No se pudo completar el ataque.")
  @@message_dict.add_word(:cannot_set_short_name, "No se puede cambiar la clave.")
  @@message_dict.add_word(:preset_roll_prompt, 
    "Pulsa \'r\' para introducir una tirada o cualquier otra tecla para tirada aleatoria.")
  @@message_dict.add_word(:bad_range, "Fuera de rango.")
  @@message_dict.add_word(:hits_success, "El ataque tiene éxito!")
  @@message_dict.add_word(:hits_fail, "El ataque falla...")
  @@message_dict.add_word(:quit_without_saving, "Saliendo sin guardar.")
  @@message_dict.add_word(:free_all_warn, "Eliminando todos los guerreros, pulsa \"y\" para continuar.")
  @@message_dict.add_word(:start_clean, "Eliminando todos los guerreros.")
  @@message_dict.add_word(:delete_backup_warn, "Eliminando la copia de seguridad, pulsa \"y\" para continuar.")
  @@message_dict.add_word(:delete_backup, "Eliminando la copia de seguridad.")
  @@message_dict.add_word(:file_not_found, "No se pudo encontrar el fichero")
  @@message_dict.add_word(:mortal_wound_hp, "     ¡Golpe que agotó los HP!")
  @@message_dict.add_word(:mortal_wound_dead_in, "     ¡Herida mortal!")
  




# *****************  help_dict  ***************** #
  valid_languages = [:english, :spanish]

  Message::Dictionary.language = :english
  @@help_dict.add_word(:already_loaded, 
    "%{short_name} is already loaded, press \'c\' to continue.")
  @@help_dict.add_word(:created_new,
    "%{short_name} has been added.")
  @@help_dict.add_word(:warrior_in_one_line, 
    "%{short_name}: %{full_name} %{nickname}")
  @@help_dict.add_word(:spawn_in_one_line, 
    "Enemy of type %{short_name}")
  @@help_dict.add_word(:warrior_in_one_line_hp, 
    "%{short_name}: %{full_name} %{nickname}: %{hp} hp")
  @@help_dict.add_word(:full_name, 
    "%{full_name}, %{nickname}")
  @@help_dict.add_word(:save_success_unique,
    "\"%{short_name}\" has been successfully saved.")
  @@help_dict.add_word(:save_success_spawn,
    "Enemy of type \"%{short_name}\" has been successfully saved.")
  @@help_dict.add_word(:save_not_exist,
    "Could not complete, %{short_name} does not exist.")
  @@help_dict.add_word(:load_fail,
    "Could not correctly load the file \"%{short_name}.marshal\".")
  @@help_dict.add_word(:load_not_exist,
    "The file \"%{short_name}\" does not exist.")
  @@help_dict.add_word(:setting_attribute,
    "Updating %{full_name}: %{attribute} = %{value}")
  @@help_dict.add_word(:free_pool,
    "Bye %{full_name}!")
  @@help_dict.add_word(:not_loaded,
    "%{short_name} has not been loaded.")
  @@help_dict.add_word(:join_combat,
    "¡%{full_name} joins the combat!")
  @@help_dict.add_word(:join_not_use_spawn,
    "%{short_name} cannot join, use \"spawn\" %{short_name} xN to spawn N.")
  @@help_dict.add_word(:not_in_combat,
    "%{short_name} is not in the combat.")
  @@help_dict.add_word(:spawn_not,
    "%{short_name} cannot be spawned.")
  @@help_dict.add_word(:spawning,
    "Spawning enemies: %{n_spawn} of type %{short_name}")
  @@help_dict.add_word(:leave_combat,
    "%{short_name} leaves the combat")
  @@help_dict.add_word(:does_not_exist,
    "\"%{short_name}\" does not exist.")
  @@help_dict.add_word(:hits_check_mod,
    "The attack modifier is %{modifier}")
  @@help_dict.add_word(:hits,
    "¡%{attacker_name} attacks %{defender_name}!")
  @@help_dict.add_word(:dead_warrior, "%{full_name} has died...")
  @@help_dict.add_word(:delete_warrior_warn, "Deleting file %{short_name}, press \"y\" to continue.")
  @@help_dict.add_word(:delete_warrior, "Deleting file %{short_name}.")
  @@help_dict.add_word(:delete_scene_warn, "Deleting scene %{short_name}, press \"y\" to continue.")
  @@help_dict.add_word(:delete_scene, "Deleting scene %{short_name}.")
  @@help_dict.add_word(:skill_not_exists, "Skill \"%{skill}\" does not exist")
  @@help_dict.add_word(:skill_puts, "   => %{skill_name}")




  Message::Dictionary.language = :spanish
  @@help_dict.add_word(:already_loaded, 
    "%{short_name} ya está cargado, pulsa \'c\' para continuar")
  @@help_dict.add_word(:created_new, 
    "Se ha añadido %{short_name}.")
  @@help_dict.add_word(:warrior_in_one_line, 
    "%{short_name}: %{full_name} %{nickname}")
  @@help_dict.add_word(:spawn_in_one_line, 
    "Enemigo de tipo %{short_name}")
  @@help_dict.add_word(:warrior_in_one_line_hp, 
    "%{short_name}: %{full_name} %{nickname}: %{hp} hp")
  @@help_dict.add_word(:full_name, 
    "%{full_name}, %{nickname}")
  @@help_dict.add_word(:save_success_unique,
    "\"%{short_name}\" se ha guardado con éxito.")
  @@help_dict.add_word(:save_success_spawn,
    "Enemigo de tipo \"%{short_name}\" se ha guardado con éxito.")
  @@help_dict.add_word(:save_not_exist,
    "No se pudo completar, %{short_name} no existe.")
  @@help_dict.add_word(:load_fail,
    "No se pudo cargar correctamente el fichero \"%{short_name}.marshal\".")
  @@help_dict.add_word(:load_not_exist,
    "El fichero \"%{short_name}\" no existe.")
  @@help_dict.add_word(:setting_attribute,
    "Actualizando %{full_name}: %{attribute} = %{value}")
  @@help_dict.add_word(:free_pool,
    "¡Adios %{full_name}!")
  @@help_dict.add_word(:not_loaded,
    "%{short_name} no está cargado.")
  @@help_dict.add_word(:join_combat,
    "¡%{full_name} se ha unido al combate!")
  @@help_dict.add_word(:join_not_use_spawn,
    "%{short_name} no se puede generar, usa \"spawn\" %{short_name} xN para generar N.")
  @@help_dict.add_word(:not_in_combat,
    "%{short_name} no está en el combate.")
  @@help_dict.add_word(:spawn_not,
    "%{short_name} no se puede generar, es un personaje.")
  @@help_dict.add_word(:spawning,
    "Generando enemigos: %{n_spawn} del tipo %{short_name}")
  @@help_dict.add_word(:leave_combat,
    "%{short_name} abandona el combate")
  @@help_dict.add_word(:does_not_exist,
    "\"%{short_name}\" no existe.")
  @@help_dict.add_word(:hits_check_mod,
    "El ataque se realiza con un modificador de %{modifier}")
  @@help_dict.add_word(:hits,
    "¡%{attacker_name} ataca a %{defender_name}!")
  @@help_dict.add_word(:dead_warrior, "%{full_name} ha muerto...")
  @@help_dict.add_word(:delete_warrior_warn, "Eliminando fichero %{short_name}, pulsa \"y\" para continuar.")
  @@help_dict.add_word(:delete_warrior, "Eliminando fichero %{short_name}.")
  @@help_dict.add_word(:delete_scene_warn, "Eliminando escena %{short_name}, pulsa \"y\" para continuar.")
  @@help_dict.add_word(:delete_scene, "Eliminando escena %{short_name}.")
  @@help_dict.add_word(:skill_not_exists, "La habilidad \"%{skill}\" no existe")
  @@help_dict.add_word(:skill_puts, "   => %{skill_name}")




# *****************  load_prompt_dict  ***************** #
  valid_languages = [:english, :spanish]
  valid_types = [:character, :foe, :spawn]

  Message::Questionnaire.set_option(:english, :character)
  @@load_prompt_dict.add_word(:loaded,
    "%{full_name} has already been loaded, press \"r\" to reload")
  @@load_prompt_dict.add_word(:reloading,
    "Reloading %{full_name}...")
  @@load_prompt_dict.add_word(:welcome,
    "Welcome, %{full_name}!")

  Message::Questionnaire.set_option(:english, :foe)
  @@load_prompt_dict.add_word(:loaded,
    "%{full_name} has already been loaded, press \"r\" to reload")
  @@load_prompt_dict.add_word(:reloading,
    "Reloading %{full_name}...")
  @@load_prompt_dict.add_word(:welcome,
    "Beware, %{full_name} is approaching!")

  Message::Questionnaire.set_option(:english, :spawn)
  @@load_prompt_dict.add_word(:loaded,
    "%{spawn_name} has already been loaded, press \"r\" to reload")
  @@load_prompt_dict.add_word(:reloading,
    "Reloading %{spawn_name}...")
  @@load_prompt_dict.add_word(:welcome,
    "Beware, some %{full_name} is approaching!")

  Message::Questionnaire.set_option(:spanish, :character)
  @@load_prompt_dict.add_word(:loaded,
    "%{full_name} ya está cargado, pulsa \"r\" para recargarlo")
  @@load_prompt_dict.add_word(:reloading,
    "Recargando %{full_name}...")
  @@load_prompt_dict.add_word(:welcome,
    "¡Bienvenido, %{full_name}!")
      
  Message::Questionnaire.set_option(:spanish, :foe)
  @@load_prompt_dict.add_word(:loaded,
    "%{full_name} ya está cargado, pulsa \"r\" para recargarlo")
  @@load_prompt_dict.add_word(:reloading,
    "Recargando %{full_name}...")
  @@load_prompt_dict.add_word(:welcome,
    "¡Se acerca %{full_name}!")

  Message::Questionnaire.set_option(:spanish, :spawn)
  @@load_prompt_dict.add_word(:loaded,
    "%{spawn_name} ya está cargado, pulsa \"r\" para recargarlo")
  @@load_prompt_dict.add_word(:reloading,
    "Recargando %{spawn_name}...")
  @@load_prompt_dict.add_word(:welcome,
    "Se acerca algún %{spawn_name}...")
    
end