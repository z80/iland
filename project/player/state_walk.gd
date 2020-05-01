
extends "res://state_machine/state.gd"

var Character = preload("res://player/Player.gd")

func enter( new_state ):
	character.play_animation( character.ANIM_WALK )


func handle_input(event):
	return .handle_input(event)


func physics_update(_delta):
	character.play_animation( character.ANIM_WALK )

	var v: Vector2 = Vector2( 0, 0 )
	var keep_walking: bool = false
	if Input.is_action_pressed( "ui_left" ):
		keep_walking = true
		v.x -= 1
	if Input.is_action_pressed( "ui_right" ):
		keep_walking = true
		v.x += 1
	if Input.is_action_pressed( "ui_up" ):
		keep_walking = true
		v.y -= 1
	if Input.is_action_pressed( "ui_down" ):
		keep_walking = true
		v.y += 1
	v.y *= 0.707107
	v *= character.move_speed
	var actual_v = character.move_and_slide( v )
	
	if  not keep_walking:
		state_machine.change_state( "idle" )





