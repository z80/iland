extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const ANIM_W: float = 512.0
const ANIM_H: float = 192.0



# Called when the node enters the scene tree for the first time.
func _ready():
	_adjust_animation_dims()
	Game.play_intro()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_start_click():
	pass



func _on_StartBtn_pressed():
	var stri: String = Game.next_level()
	print( "Set level: ", stri )
	Game.set_score( 0 )
	Game.reset_enemy_qty()
	Game.change_state( stri )
	#Game.change_state( "d_level" )
	


func _on_ExitBtn_pressed():
	get_tree().quit()


func _adjust_animation_dims():
	var viewport = get_tree().root
	var sz = viewport.size
	var sw: float = sz.x/ANIM_W
	var sh: float = sz.y/ANIM_H
	var s: float
	if (sw < sh): 
		s = sw 
	else: 
		s = sh
	$Control/AnimatedSprite.scale = Vector2(s, s)

