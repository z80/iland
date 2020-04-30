
extends "res://state_machine/state.gd"

func enter( new_state ):
	character.play_animation( character.ANIM_FIRE, character.gun_animation_speed )


func on_animation_finished():
	state_machine.change_state( "prev" )
