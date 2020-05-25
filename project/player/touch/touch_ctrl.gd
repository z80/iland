
extends Control


const ACTION_FIRE: String = "ui_fire"

var fire_en: bool = false


func _ready():
	var touch: bool = Game.use_touch_controls()
	# 1) Make touch controlls visible/invisible.
	visible = touch
	# 2) Block mouse "fire".
	if touch:
		InputMap.action_erase_events( ACTION_FIRE )




func _on_FireBtn_pressed():
	fire_en = not fire_en
	if fire_en:
		Input.action_press( ACTION_FIRE )
	else:
		Input.action_release( ACTION_FIRE )



func _on_MenuBtn_pressed():
	Game.change_state( "pause_menu" )




