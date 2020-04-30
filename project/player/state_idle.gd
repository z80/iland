
extends "res://state_machine/state.gd"

var Character = preload("res://player/Player.gd")

func enter( new_state ):
	character.play_animation( character.ANIM_IDLE )


func physics_update( _delta ):
	if Input.is_action_pressed( "ui_left" ) or \
		Input.is_action_pressed( "ui_right" ) or \
		Input.is_action_pressed( "ui_up" ) or \
		Input.is_action_pressed( "ui_down" ):
			
		state_machine.change_state( "walk" )
	
	else:
		# Adjust direction.
		character.play_animation( character.ANIM_IDLE )
