
extends "res://state_machine/state.gd"

func enter( new_state ):
	character.play_animation( character.ANIM_FIRE )


func on_animation_finished( _anim_name ):
	var d = character.target_dist()
	if d < character.fire_distance:
		character.target.hit( 50 )
	state_machine.change_state( "prev" )
