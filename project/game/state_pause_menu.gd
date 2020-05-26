
extends "res://state_machine/state.gd"

var PauseMenu = preload( "res://menus/pause_menu.tscn" )
var pause_menu = null


func enter( new_state ):
	.enter( new_state )
	if not pause_menu:
		pause_menu = PauseMenu.instance()
		var vp = get_tree().get_root()
		vp.add_child( pause_menu )
		
	pause_menu.state = self
	pause_menu.visible = true
	
	Game.set_mouse_visible( true )

	var tree = get_tree()
	tree.paused = true


func exit( destroy ):
	if pause_menu:
		if destroy:
			pause_menu.queue_free()
			pause_menu = null
		else:
			pause_menu.visible = false
	var tree = get_tree()
	tree.paused = false


func handle_input( event ):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			state_machine.change_state( "prev" )






