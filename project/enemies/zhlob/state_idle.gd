
extends "res://state_machine/state.gd"

var Character = preload("res://enemies/zhlob/zhlob.gd")

func enter():
	#character
	owner.get_node("AnimatedSprite").play("idle")


func handle_input(event):
	return .handle_input(event)


func update(_delta):
	#var input_direction = get_input_direction()
	#if input_direction:
	#	emit_signal("finished", "move")
	pass
