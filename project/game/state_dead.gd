
extends "res://state_machine/state.gd"


func enter( new_state ):
	var tree = get_tree()
	tree.paused = true


func handle_input(event):
	pass


func physics_update(_delta):
	pass


