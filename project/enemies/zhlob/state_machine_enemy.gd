
extends "res://state_machine/state_machine.gd"

func _init_states_map( sm ):
	._init_states_map( sm )
	sm["idle"] = $Idle
	sm["walk"] = $Walk
	sm["fire"] = $Fire
	sm["hit"]  = $Fit
	sm["die"]  = $Die
	sm["dead"] = $Dead


