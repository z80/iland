
extends "res://state_machine/state_machine.gd"

# This one can be accessed by all the states.
var game = null

func _init_states_map( sm ):
	._init_states_map( sm )
	sm["main_menu"] = $MainMenu
	sm["level_00"]  = $Level_00
	sm["dead"]      = $Dead
	
	start_state_name = "level_00"
	
	game = get_parent()
	


