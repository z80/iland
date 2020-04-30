
extends "res://state_machine/state.gd"

# Initialize the state. E.g. change the animation.
func enter( new_state ):
	#character.play_animation( character.ANIM_HIT )
	# Right now don't have hit animation. Just exit
	state_machine.change_state( "prev" )



