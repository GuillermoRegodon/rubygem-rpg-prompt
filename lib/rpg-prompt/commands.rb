ParseLine::Line.add_command(:quit, /quit/, ["s", "q"])
ParseLine::Line.add_command(:quit_short, /qqq/, [])

# These are loaded in rules.rb to allow the modification
# ParseLine::Line.add_command(:hits,
#  /(?<atk>\w+) hits (?<def>\w+)/, ["c", "f", "r", "h", "s", "u", "d"])
# ParseLine::Line.add_command(:hits_short,
#   /(?<atk>\w+) h (?<def>\w+)/, ["c", "f", "r", "h", "s", "u", "d"])

# ParseLine::Line.add_command(:skill,
#   /skill (?<ch>\w+) (?<skill>\w+)( [+-]\d+)?/,
#   ["c", "r", "e", "l", "m", "h", "v", "e", "s", "a", "c", "u", "i", "d", "p"])
# ParseLine::Line.add_command(:skill_short,
#   /(?<ch>\w+)( )?:( )?(?<skill>\w+)( [+-]\d+)?/,
#   ["c", "r", "e", "l", "m", "h", "v", "e", "s", "a", "c", "u", "i", "d", "p"])
ParseLine::Line.add_command(:skill_help, /skill_help (?<skill>\w+)/, [])
ParseLine::Line.add_command(:skill_help_short, /sh (?<skill>\w+)/, [])
ParseLine::Line.add_command(:skill_list, /skill_list/, [])

ParseLine::Line.add_command(:join, /join (?<name>\w+)/, [])
ParseLine::Line.add_command(:spawn, /spawn (?<name>\w+) x(?<number>[^0]\d*)/, [])
ParseLine::Line.add_command(:leave, /leave (?<name>\w+)/, [])

ParseLine::Line.add_command(:round, /round( \+(?<number>\d+))?/, [])

ParseLine::Line.add_command(:pool, /pool/, [])
ParseLine::Line.add_command(:pool_short, /p/, [])

ParseLine::Line.add_command(:combat_status,
  /combatstatus( (?<name>\w+))?/, ["v"])
ParseLine::Line.add_command(:combat_status_short,
  /s( (?<name>\w+))?/, ["v"])
ParseLine::Line.add_command(:combat_status_short_verbose,
  /sv( (?<name>\w+))?/, [])

ParseLine::Line.add_command(:create_character, /createchar (?<name>\w+)/, [])
ParseLine::Line.add_command(:create_character_short, /cc (?<name>\w+)/, [])
ParseLine::Line.add_command(:create_foe, /createfoe (?<name>\w+)/, [])
ParseLine::Line.add_command(:create_foe_short, /cf (?<name>\w+)/, [])
ParseLine::Line.add_command(:create_spawn, /createspawn (?<name>\w+)/, [])
ParseLine::Line.add_command(:create_spawn_short, /cs (?<name>\w+)/, [])

ParseLine::Line.add_command(:set_attribute,
  /set (?<name>\w+) (?<attribute>\w+) (?<val>\w+)/, [])

ParseLine::Line.add_command(:list_warriors, /lw/, [])
ParseLine::Line.add_command(:save_warrior, /save w (?<name>\w+)/, [])
ParseLine::Line.add_command(:load_warrior, /load w (?<name>\w+)/, ["r"])
ParseLine::Line.add_command(:delete_warrior, /delete w (?<name>\w+)/, ["r"])
ParseLine::Line.add_command(:save_warrior_short, /sw (?<name>\w+)/, [])
ParseLine::Line.add_command(:load_warrior_short, /lw (?<name>\w+)/, ["r"])
ParseLine::Line.add_command(:delete_warrior_short, /dw (?<name>\w+)/, ["r"])

ParseLine::Line.add_command(:list_scenes, /ls/, [])
ParseLine::Line.add_command(:save_scene, /save s (?<name>\w+)/, [])
ParseLine::Line.add_command(:load_scene, /load s (?<name>\w+)/, ["r"])
ParseLine::Line.add_command(:delete_scene, /delete s (?<name>\w+)/, ["r"])
ParseLine::Line.add_command(:save_scene_short, /ss (?<name>\w+)/, [])
ParseLine::Line.add_command(:load_scene_short, /ls (?<name>\w+)/, ["r"])
ParseLine::Line.add_command(:delete_scene_short, /ds (?<name>\w+)/, ["r"])

ParseLine::Line.add_command(:free, /free (?<name>\w+)/, [])
ParseLine::Line.add_command(:free_all, /free all/, [])

ParseLine::Line.add_command(:help, /help/, [])
ParseLine::Line.add_command(:example, /example/, [])

ParseLine::Line.add_command(:undo, /undo/, [])
ParseLine::Line.add_command(:test, /t/, [])
ParseLine::Line.add_command(:empty, / /, [])

ParseLine::Line.add_command(:clone, /clone rules (?<system>\w+)/, [])

ParseLine::Line.add_command(:quick_backup, /bbb/, [])
ParseLine::Line.add_command(:restore_backup, /rrr/, [])
ParseLine::Line.add_command(:delete_backup, /ddd/, [])