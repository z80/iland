
extends "res://state_machine/state.gd"

# Initialize the state. E.g. change the animation.
func enter( new_state ):
	var target_at = character.target.global_position
	var own_at = character.global_position
	var dv = target_at - own_at
	character.line_of_sight = dv
	
	character.play_animation( character.ANIM_HIT )


func on_animation_finished():
	state_machine.change_state( "prev" )
