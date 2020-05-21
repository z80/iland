
extends Control


const ACTION_FIRE: String = "ui_fire"

var fire_en: bool = false


func _ready():
	var touch: bool = Game.use_touch_controls()
	visible = touch
	if touch:
		InputMap.action_erase_events( "ui_fire" )




func _on_FireBtn_pressed():
	fire_en = not fire_en
	if fire_en:
		Input.action_press( ACTION_FIRE )
	else:
		Input.action_release( ACTION_FIRE )

