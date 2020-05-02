
extends Node
# Base interface for all states: it doesn't do anything by itself,
# but forces us to pass the right arguments to the methods below
# and makes sure every State object had all of these methods.

# warning-ignore:unused_signal
signal finished( next_state_name )

var state_machine = null
var character     = null
var active: bool = false

func initialize():
	pass

# Initialize the state. E.g. change the animation.
func enter( new_state ):
	active = true


# Clean up the state. Reinitialize values like a timer.
func exit( destroyed ):
	active = false


func handle_input( _event ):
	pass


func physics_update( _delta ):
	pass


func on_animation_finished():
	pass
