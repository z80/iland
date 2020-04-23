
extends Node2D

func __init():
	pass


func sample( direction_string: String ):
	# Pick random animation And play it till the very end
	var ind: int = randi() % 3
	var stri: String
	if ind == 0:
		stri = "Shell_00"
	elif ind == 1:
		stri = "Shell_01"
	else:
		stri = "Shell_02"
	stri = "Shell_00"
	stri = stri + direction_string
	$AnimatedSprite.animation = stri
	$AnimatedSprite.playing = true


func _on_Timer_timeout():
	queue_free()


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.playing = false
	$Timer.start()


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.playing = false
