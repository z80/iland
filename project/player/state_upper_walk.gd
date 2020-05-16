
extends "res://state_machine/state.gd"

var Character = preload("res://player/Player.gd")

func enter( new_state ):
	character.play_animation_upper( character.ANIM_WALK, true )


func handle_input(event):
	return .handle_input(event)


func physics_update(_delta):
	character.play_animation_upper( character.ANIM_WALK, true )

	var keep_walking: bool = false
	if Input.is_action_pressed( "ui_left" ):
		keep_walking = true
	if Input.is_action_pressed( "ui_right" ):
		keep_walking = true
	if Input.is_action_pressed( "ui_up" ):
		keep_walking = true
	if Input.is_action_pressed( "ui_down" ):
		keep_walking = true
	
	if  not keep_walking:
		state_machine.change_state( "idle" )





