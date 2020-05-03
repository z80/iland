extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#var vp = get_tree().get_root()
	#var prt = get_parent()
	#if vp != prt:
	#	vp.add_child( self )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_start_click():
	pass
	


func _on_StartBtn_pressed():
	#get_tree().change_scene( "res://levels/level_00.tscn" ) # Replace with function body.
	Game.change_state( "level_00" )
	


func _on_ExitBtn_pressed():
	get_tree().quit()
	

