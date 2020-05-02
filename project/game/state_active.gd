
extends "res://state_machine/state.gd"

# This state is a base for all other states except 
# the dead player one.
# The idea is this one will react on "esc" and display 
# the exit menu and pause the game.

func enter( new_state ):
	if not main_menu:
		main_menu = MainMenu.instance()
		var vp = get_tree().get_root()
		vp.add_child( main_menu )
		
	main_menu.visible = true


func exit( destroy ):
	if destroy:
		main_menu.queue_free()
		main_menu = null
	else:
		main_menu.visible = false


func handle_input(event):
	pass


func physics_update(_delta):
	pass


