
extends "res://state_machine/state.gd"

var DoneMenu = preload( "res://menus/done_menu.tscn" )
var done_menu = null


func enter( new_state ):
	.enter( new_state )
	if not done_menu:
		done_menu = DoneMenu.instance()
		var vp = get_tree().get_root()
		vp.add_child( done_menu )
		
	done_menu.state = self
	done_menu.visible = true
	
	Game.set_mouse_visible( true )



func exit( destroy ):
	if done_menu:
		if destroy:
			done_menu.queue_free()
			done_menu = null
		else:
			done_menu.visible = false









