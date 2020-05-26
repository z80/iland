extends Area2D

const TOUCH_DIST: int = 512

# Direction relative to the player.
var touch_dir: Vector2 = Vector2( TOUCH_DIST, 0.0 )
# Pointer to the player object
var player = null



func set_dir( dir: Vector2 ):
	var l: float = dir.length()
	if l > 0.0:
		touch_dir = dir * ( TOUCH_DIST / l )


# Called when the node enters the scene tree for the first time.
func _ready():
	$SpriteRed.visible = false
	$SpriteGreen.visible = true
	$SpriteRed.z_index   = Game.LAYER_FLYING_OBJECT
	$SpriteGreen.z_index = Game.LAYER_FLYING_OBJECT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var touch: bool = Game.use_touch_controls()
	if not touch:
		# Place cursor where mouse position is
		var at = get_global_mouse_position()
		position = at
	else:
		if not player:
			return
		var player_at: Vector2 = player.position
		_recompute_touch_dir()
		var at: Vector2 = player_at + touch_dir
		position = at
		


func _on_Crosshair_area_entered(area):
	$SpriteRed.visible   = true
	$SpriteGreen.visible = false

func _recompute_touch_dir():
	var aim_up:    float = Input.get_action_strength( "aim_down" )
	var aim_down:  float = Input.get_action_strength( "aim_up" )
	var aim_left:  float = Input.get_action_strength( "aim_left" )
	var aim_right: float = Input.get_action_strength( "aim_right" )
	
	#print( "%f, %f, %f, %f" % [ aim_up, aim_down, aim_left, aim_right ] )
	
	var v: Vector2 = Vector2( aim_right - aim_left, aim_up - aim_down )
	if v != Vector2.ZERO:
		v = v.normalized()
		touch_dir = v * TOUCH_DIST
		#print( "touch_dir: (%f, %f)" % [ touch_dir.x, touch_dir.y ] )
	return touch_dir


func _on_Crosshair_area_exited(area):
	$SpriteRed.visible   = false
	$SpriteGreen.visible = true
