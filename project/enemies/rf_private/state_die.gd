
extends "res://state_machine/state.gd"

var sound = preload( "res://enemies/rf_private/sounds/death_00.ogg" )

func _ready():
	sound.set_loop( false )

# Initialize the state. E.g. change the animation.
func enter( new_animation ):
	var target_at = character.target.global_position
	var own_at = character.global_position
	var dv = target_at - own_at
	character.line_of_sight = dv

	character.play_animation( character.ANIM_DIE )
	character.play_sound( sound )


func on_animation_finished():
	character.stop_animation()
	state_machine.change_state( "dead" )
