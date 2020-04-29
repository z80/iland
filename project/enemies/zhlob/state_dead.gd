
extends "res://state_machine/state.gd"

# Initialize the state. E.g. change the animation.
func enter( new_animation ):
	var timer = character.get_node( "Timer" )
	timer.connect( "timeout", self, "_on_timer_elapsed" )


func _on_timer_elapsed():
	character.queue_free()
	
