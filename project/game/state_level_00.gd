
extends "res://game/state_active.gd"


func enter( new_state ):
	.enter( new_state )
	get_tree().change_scene( "res://levels/level_00.tscn" )

func exit( destroy ):
	.exit( destroy )
	
	
func handle_input( event ):
	.handle_input( event )


func physics_update(_delta):
	pass

