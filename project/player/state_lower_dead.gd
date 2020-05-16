
extends "res://state_machine/state.gd"

# Initialize the state. E.g. change the animation.
func enter( new_animation ):
	var timer = character.get_node( "Timer" )
	timer.connect( "timeout", self, "_on_timer_elapsed" )
	timer.wait_time = 2.0
	timer.start()
	# Do nothing. It just remains dead.
	# Keep it look dead.
	character.stop_animation_lower( 8 )
	character.set_collision( false )
	
	# On death


func _on_timer_elapsed():
	Game.change_state( "dead_menu" )
	
