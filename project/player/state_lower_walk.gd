
extends "res://state_machine/state.gd"

var Character = preload("res://player/Player.gd")

func enter( new_state ):
	character.play_animation_lower( character.ANIM_WALK )
	#print( "lower walk" )


func handle_input(event):
	return .handle_input(event)


func physics_update(_delta):
	# Adjust direction
	character.play_animation_lower( character.ANIM_WALK )

	var v: Vector2 = Vector2( 0, 0 )
	var keep_walking: bool = false
	
	var up:    float = Input.get_action_strength( "ui_down" )
	var down:  float = Input.get_action_strength( "ui_up" )
	var left:  float = Input.get_action_strength( "ui_left" )
	var right: float = Input.get_action_strength( "ui_right" )
	v.x = right - left
	v.y = up - down
	v.y *= 0.707107
	keep_walking = (v != Vector2.ZERO)

	v *= character.move_speed
	var actual_v = character.move_and_slide( v )
	
	if  not keep_walking:
		state_machine.change_state( "idle" )





