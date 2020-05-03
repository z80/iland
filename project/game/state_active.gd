
extends "res://state_machine/state.gd"

# This state is a base for all other states except 
# the dead player one.
# The idea is this one will react on "esc" and display 
# the exit menu and pause the game.

func enter( new_state ):
	.enter( new_state )

func exit( destroy ):
	.exit( destroy )

func handle_input( event ):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			state_machine.change_state( "pause_menu" )


func physics_update(_delta):
	pass



