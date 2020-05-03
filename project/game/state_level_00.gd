
extends "res://game/state_active.gd"

var created: bool = false

func enter( new_state ):
	.enter( new_state )
	if not created:
		get_tree().change_scene( "res://levels/level_00.tscn" )
		created = true


func exit( destroy ):
	.exit( destroy )
	if destroy:
		created = false
	
	
func handle_input( event ):
	.handle_input( event )


func physics_update(_delta):
	pass

