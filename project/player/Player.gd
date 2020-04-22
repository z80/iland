extends KinematicBody2D

export(int) var move_speed = 500
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum {ANIM_IDLE=0, ANIM_WALK=1, ANIM_FIRE=2}
enum {DIR_000=0, DIR_045=1, DIR_090=2, DIR_135=3, DIR_180=4, DIR_225=5, DIR_270=6, DIR_315=7}

export(int)  var anim = ANIM_IDLE
export(int)  var anim_fire_prev = ANIM_IDLE
export(bool) var anim_fire_continuous = false
export(int)  var dir  = DIR_000

# Signals player emits.
# Gun objects receive and process these.
signal gun_activate
signal gun_shoot_start
signal gun_shoot_end
signal gun_switch

# Receives a signal from a gun to start fire animation.
# gun_animation_start( speed_scale )
# gun_fire_animation_stop() - this ne only is called when gun fire is continuous.

var Crosshair = preload( "res://crosshair/Crosshair.tscn" )
var crosshair = null

var Hud = preload( "res://hud/Hud.tscn" )
var hud = null

# Create all the guns
var guns = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make camera 2d current.
	$Camera2D.make_current()
	
	# Make it play animation all the time.
	$AnimatedSprite.playing = true
	
	# Create Crosshair.
	var vp = get_tree().get_root()
	crosshair = Crosshair.instance()
	vp.add_child( crosshair )
	crosshair.visible = true

	hud = Hud.instance()
	vp.add_child( hud )
	hud.visible = true
	
	_create_guns()
	
	connect( "gun_animation_start", self, self._on_gun_animation_start )

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
	v.y *= 0.707107
	v *= move_speed
	var actual_v = move_and_slide( v )
	#for i in get_slide_count():
	#	var collision = get_slide_collision(i)
	#	print("Collided with: ", collision.collider.name)
	#var p = position
	#print( "v: ", v, ", p: ", p )
	
	
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
	
func _create_guns():
	var Gun = preload( "res://gun/Gun.gd" )
	var gun = Gun.instance()
	guns.append( gun )
	gun.player = self
	gun.active = true
	

func _on_gun_animation_start( speed := 1.0 ):
	anim_fire_prev = anim
	anim = ANIM_FIRE
	anim_fire_continuous = false
	$AnimatedSprite.speed_scale = speed

#func _on_gun_animation_stop():
#	anim = ANIM_FIRE
#	anim_fire_continuous = false
#	# Later on it will stop when animation finishes.

func _on_AnimatedSprite_animation_finished():
	if ( anim != ANIM_FIRE ):
		return
	if ( !anim_fire_continuous ):
		return
	anim = anim_fire_prev
	$AnimatedSprite.speed_scale = 1.0
