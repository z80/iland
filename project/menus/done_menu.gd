
extends Node2D


var state = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ExitBtn_pressed():
	var tree = get_tree()
	tree.paused = false
	
	Game.change_state( "main_menu", true )


func _on_BackToGame_pressed():


func _on_NextLevelBtn_pressed():
	Game.change_state( "level_01", true )
