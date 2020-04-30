
extends "res://state_machine/state.gd"

var Character = preload("res://enemies/zhlob/zhlob.gd")

func enter( new_state ):
	character.play_animation( character.ANIM_IDLE )

func handle_input(event):
	return .handle_input(event)


func physics_update(_delta):
	var d = character.target_dist()
	if d <= character.sight_distance:
		if d > character.fire_distance:
			var target_at = character.target.global_position
			var own_at = character.global_position
			var dv = target_at - own_at
			character.line_of_sight = dv
			state_machine.change_state( "walk" )
		else:
			state_machine.change_state( "fire" )
