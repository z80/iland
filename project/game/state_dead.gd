
extends "res://state_machine/state.gd"


func enter( new_state ):
	#var tree = get_tree()
	#tree.paused = true
	
	# For now just go to pause menu.
	state_machine.change_state( "dead_menu" )


func handle_input(event):
	pass


func physics_update(_delta):
	pass


