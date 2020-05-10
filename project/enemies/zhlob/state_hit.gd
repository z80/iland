
extends "res://state_machine/state.gd"

# Initialize the state. E.g. change the animation.
func enter( new_state ):
	character.play_animation( character.ANIM_HIT, true )


func on_animation_finished():
	state_machine.change_state( "prev" )
