
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
	
	var touch: bool = Game.use_touch_controls()
	if touch:
		var ui_up:    float = Input.get_action_strength( "ui_down" )
		var ui_down:  float = Input.get_action_strength( "ui_up" )
		var ui_left:  float = Input.get_action_strength( "ui_left" )
		var ui_right: float = Input.get_action_strength( "ui_right" )
		v.x = ui_right - ui_left
		v.y = ui_up - ui_down
		if v != Vector2.ZERO:
			keep_walking = true
			v = v.normalized()
	else:
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





