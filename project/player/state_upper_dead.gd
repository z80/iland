
extends "res://state_machine/state.gd"

# Initialize the state. E.g. change the animation.
func enter( new_animation ):
	# Keep it look dead.
	character.stop_animation_upper( 8 )


	
