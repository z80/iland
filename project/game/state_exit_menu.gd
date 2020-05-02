
extends "res://game/state_active.gd"

var ExitMenu = preload( "res://menus/back_to_menu.tscn" )
var exit_menu = null

func enter( new_state ):
	.enter( new_state )
	if not exit_menu:
		exit_menu = ExitMenu.instance()
		var vp = get_tree().get_root()
		vp.add_child( exit_menu )
		
	exit_menu.state = self
	exit_menu.visible = true


func handle_input( event ):
	.handle_inut( event )
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			state_machine.change_state( "prev" )






