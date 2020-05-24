
extends "res://game/state_active.gd"

var created: bool = false

func enter( new_state ):
	.enter( new_state )
	if (not created) or new_state:
		get_tree().change_scene( "res://levels/level_01.tscn" )
		created = true
		
	Game.set_mouse_visible( false )
	Game.set_next_level( "level_01" )


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

