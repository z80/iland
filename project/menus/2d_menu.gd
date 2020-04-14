extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Player = preload( "res://player/Player.tscn" )


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_start_click():
	pass
	


func _on_StartBtn_pressed():
	get_tree().change_scene( "res://levels/level_00.tscn" ) # Replace with function body.
	var player = Player.instance()
	player.set_position( Vector2() )


func _on_ExitBtn_pressed():
	get_tree().quit()
	

