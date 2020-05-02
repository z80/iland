
extends "res://state_machine/state.gd"

var MainMenu = preload( "res://menus/main_menu.tscn" )


func enter( new_state ):
	get_tree().change_scene( "res://menu/main_menu.tscn" )


func handle_input(event):
	pass


func physics_update(_delta):
	pass


