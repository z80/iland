
extends "res://state_machine/state.gd"

var MainMenu = preload( "res://menus/2d_menu.tscn" )

var main_menu: null

func enter( new_state ):
	main_menu = MainMenu.instance()
	var vp = get_tree().get_root()
	vp.add_child( main_menu )


func handle_input(event):
	pass


func physics_update(_delta):
	pass


