
extends "res://state_machine/state.gd"

func enter( new_state ):
	character.play_animation_upper( character.ANIM_FIRE )


func physics_update( _delta ):
	character.play_animation_upper( character.ANIM_FIRE )


func on_animation_finished():
	#state_machine.change_state( "prev" )
	pass
