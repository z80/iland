
extends "res://state_machine/state.gd"


var created: bool = false

func enter( new_state ):
	.enter( new_state )
	var res = get_tree().change_scene( "res://debug/d_main_menu.tscn" )


func exit( destroy ):
	.exit( destroy )
	if destroy:
		var menu = Game.find_node_by_name( "DMainMenu" )
		if menu:
			menu.queue_free()
	
	
func handle_input( event ):
	.handle_input( event )



