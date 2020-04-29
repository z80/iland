
extends "res://state_machine/state.gd"

# Initialize the state. E.g. change the animation.
func enter( new_animation ):
	character.play_animation( character.ANIM_DIE )


func on_animation_finished( _anim_name ):
	character.stop_playing()
	state_machine.change_state( "dead" )
