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
	var stri: String = Game.next_level()
	print( "Set level: ", stri )
	Game.reset_enemy_qty()
	Game.change_state( stri )
	#Game.change_state( "d_level" )
	


func _on_ExitBtn_pressed():
	get_tree().quit()
	

