
extends "res://state_machine/state_machine.gd"

func _init_states_map( sm ):
	._init_states_map( sm )
	sm["idle"] = $Idle
	sm["walk"] = $Walk
	sm["die"]  = $Die
	sm["dead"] = $Dead
	
	start_state_name = "idle"
	
	character = get_parent()
	


