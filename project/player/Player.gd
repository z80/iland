extends KinematicBody2D

export(int) var move_speed = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum {ANIM_IDLE=0, ANIM_WALK=1, ANIM_FIRE=2}
enum {DIR_000=0, DIR_045=1, DIR_090=2, DIR_135=3, DIR_180=4, DIR_225=5, DIR_270=6, DIR_315=7}

export(int) var anim = ANIM_IDLE
export(int) var dir  = DIR_000

var Crosshair = preload( "res://crosshair/Crosshair.tscn" )
var crosshair = null
# Called when the node enters the scene tree for the first time.
func _ready():
	# Make camera 2d current.
	$Camera2D.make_current()
	
	# Create Crosshair.
	var vp = get_tree().get_root()
	crosshair = Crosshair.instance()
	vp.add_child( crosshair )
	crosshair.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var v = Vector2()
	v.x -= 1 if Input.is_action_pressed( "ui_left" ) else 0
	v.x += 1 if Input.is_action_pressed( "ui_right" ) else 0
	v.y -= 1 if Input.is_action_pressed( "ui_up" ) else 0
	v.y += 1 if Input.is_action_pressed( "ui_down" ) else 0
	var new_anim = null
	if ( v.x != 0 ) or ( v.y != 0 ):
		new_anim = ANIM_WALK
	else:
		new_anim = ANIM_IDLE
	var update_animation = false
	var new_dir = _compute_dir()
	if ( dir != new_dir ):
		update_animation = true
		dir = new_dir
	if ( update_animation or (anim != new_anim) ):
		anim = new_anim
		var dir_stri = null
		if ( dir == DIR_000 ):
			dir_stri = '_000'
		elif ( dir == DIR_045 ):
			dir_stri = '_045'
		elif ( dir == DIR_090 ):
			dir_stri = '_090'
		elif ( dir == DIR_135 ):
			dir_stri = '_135'
		elif ( dir == DIR_180 ):
			dir_stri = '_180'
		elif ( dir == DIR_225 ):
			dir_stri = '_225'
		elif ( dir == DIR_270 ):
			dir_stri = '_270'
		elif ( dir == DIR_315 ):
			dir_stri = '_315'
		else:
			new_dir = _compute_dir()
		if ( anim == ANIM_WALK ):
			$AnimatedSprite.animation = 'Walk' + dir_stri
		elif ( anim == ANIM_IDLE ):
			$AnimatedSprite.animation = 'Idle' + dir_stri
	#$AnimatedSprite.play()
	v.y *= 0.5
	v *= move_speed
	#print( "v: ", v )
	move_and_slide( v )
	
	
func _compute_dir():
	var c_at = crosshair.position
	var p_at = position
	var a = c_at - p_at
	var angle = atan2( a.y, a.x )
	var _pi_4 = PI*0.25
	var d = int(round( angle / _pi_4 ))
	if ( d < 0 ):
		d += 8
	return d
	








