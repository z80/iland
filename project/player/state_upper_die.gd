
extends "res://state_machine/state.gd"

#var sound = preload( "res://enemies/sounds/death_00.ogg" )

func _ready():
	#sound.set_loop( false )
	pass

# Initialize the state. E.g. change the animation.
func enter( new_animation ):
	character.play_animation_upper( character.ANIM_DIE, true )
	#character.play_sound( sound )


func on_animation_finished():
	character.stop_animation_upper()
	state_machine.change_state( "dead" )
