
extends "res://game/state_active.gd"

var Level00 = preload( "res://levels/level_00.tscn" )

var created: bool = false

func enter( new_state ):
	.enter( new_state )
	if not created:
		get_tree().change_scene( "res://levels/level_00.tscn" )
		created = true
		
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func exit( destroy ):
	.exit( destroy )
	if destroy:
		var level = Game.find_node_by_name( "Level00" )
		if level:
			level.queue_free()
			created = false
	
	
func handle_input( event ):
	.handle_input( event )


func physics_update(_delta):
	pass

