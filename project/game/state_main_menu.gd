
extends "res://state_machine/state.gd"

var MainMenu = preload( "res://menus/main_menu.tscn" )
var menu = null

func enter( new_state ):
	#if not menu:
	get_tree().change_scene( "res://menus/main_menu.tscn" )
	Game.set_mouse_visible( true )
		#menu = Game.find_node_by_name( "MainMenu" )
	#else:
	#	menu.visible = true

func exit( destroy ):
	#if menu:
	#	menu.visible = false
	pass

func handle_input(event):
	pass


func physics_update(_delta):
	pass


