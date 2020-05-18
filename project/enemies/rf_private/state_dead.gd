
extends "res://state_machine/state.gd"

# Initialize the state. E.g. change the animation.
func enter( new_animation ):
	var timer = character.get_node( "Timer" )
	timer.connect( "timeout", self, "_on_timer_elapsed" )
	timer.start()
	
	# Keep it look dead.
	character.stop_animation( 24 )
	character.set_collision( false )
	character.spawn_medikit()
	Game.dec_enemy_qty()


func _on_timer_elapsed():
	character.queue_free()
	
