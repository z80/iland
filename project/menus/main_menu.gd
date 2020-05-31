extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const ANIM_W: float = 512.0
const ANIM_H: float = 192.0



# Called when the node enters the scene tree for the first time.
func _ready():
	_adjust_animation_dims()
	_show_demo()
	_show_version()
	OS.window_fullscreen = true
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


func _show_demo():
	var d: bool = Globals.demo()
	$ItchDemo.visible = d
	$ItchGet.visible  = d



func _show_version():
	var v: String = Globals.version()
	v = "version: {s}".format( {"s": v} )
	$Version.text = v





func _on_InchGet_pressed():
	OS.shell_open("https://dr_livsey.itch.io/sturmgewher")
	


func _on_MainMenu_resized():
	_adjust_animation_dims()


func _on_FullscreenBtn_pressed():
	OS.window_fullscreen = not OS.window_fullscreen
