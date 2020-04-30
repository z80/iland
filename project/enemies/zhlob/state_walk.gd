
extends "res://state_machine/state.gd"

var Character = preload("res://enemies/zhlob/Zhlob.gd")

func enter( new_state ):
	var target_at = character.target.global_position
	var own_at = character.global_position
	var dv = target_at - own_at
	character.line_of_sight = dv
	character.play_animation( character.ANIM_WALK )


func handle_input(event):
	return .handle_input(event)


func physics_update(_delta):
	var d = character.target_dist()
	if d > character.sight_distance:
		# Change back to "idle".
		state_machine.change_state( "previous" )
		return
	elif d <= character.fire_distance:
		state_machine.change_state( "fire" )
		return
	
	# Update azimuth and move towards the player.
	var target_at = character.target.global_position
	var own_at = character.global_position
	var dv = target_at - own_at
	character.line_of_sight = dv
	character.play_animation( character.ANIM_WALK )

	var v = dv.normalized()
	v.y *= 0.707107
	v *= character.move_speed
	var actual_v = character.move_and_slide( v )
