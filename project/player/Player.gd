extends KinematicBody2D

export(int) var move_speed = 500
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum {ANIM_IDLE=0, ANIM_WALK=1, ANIM_FIRE=2, ANIM_DIE=3}
enum {DIR_000=0, DIR_045=1, DIR_090=2, DIR_135=3, DIR_180=4, DIR_225=5, DIR_270=6, DIR_315=7}

export(int)  var anim = ANIM_IDLE
export(int)  var anim_fire_prev = ANIM_IDLE
#export(bool) var anim_fire_continuous = false
export(int)  var dir  = DIR_000

# Receives a signal from a gun to start fire animation.
# gun_animation_start( speed_scale )
# gun_fire_animation_stop() - this ne only is called when gun fire is continuous.

var Crosshair = preload( "res://crosshair/Crosshair.tscn" )
var crosshair = null

var Hud = preload( "res://hud/Hud.tscn" )
var hud = null

# Create all the guns
var guns = []
var gun = null
var gun_category = 0
var gun_index = 0
# Used by "fire" state
var gun_animation_speed: float = 1.0

var health: int = 100

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

	#hud = Hud.instance()
	#vp.add_child( hud )
	#hud.visible = true
	
	_create_guns()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process( delta ):
	# Process firing
	_process_firing()





func play_animation( anim, speed := 1.0 ):
	var d = _compute_dir()
	var stri = _animation_name( anim, d )
	var current_stri = $AnimatedSprite.animation
	if current_stri != stri:
		$AnimatedSprite.animation = stri
	if $AnimatedSprite.speed_scale != speed:
		$AnimatedSprite.speed_scale = speed
	if not $AnimatedSprite.playing:
		$AnimatedSprite.play()


func stop_animation():
	$AnimatedSprite.playing = false
	

func play_sound( sound ):
	$AudioStreamPlayer.stream = sound
	$AudioStreamPlayer.play()
	
func change_state( state_name ):
	# To change state from outside.
	# For example, by a gun.
	$StateMachine.change_state( state_name )
	
	
	
	
	
func _animation_dir_name( direction ):
	var dir_stri: String
	if ( direction == DIR_000 ):
		dir_stri = '_000'
	elif ( direction == DIR_045 ):
		dir_stri = '_045'
	elif ( direction == DIR_090 ):
		dir_stri = '_090'
	elif ( direction == DIR_135 ):
		dir_stri = '_135'
	elif ( direction == DIR_180 ):
		dir_stri = '_180'
	elif ( direction == DIR_225 ):
		dir_stri = '_225'
	elif ( direction == DIR_270 ):
		dir_stri = '_270'
	elif ( direction == DIR_315 ):
		dir_stri = '_315'
	else:
		dir_stri = '_000'
		
	return dir_stri	
	
	
func _animation_name( animation, dir ):
	var dir_stri: String = _animation_dir_name( dir )
	var anim_stri: String
	if ( animation == ANIM_WALK ):
		anim_stri = 'Walk'
	elif ( animation == ANIM_FIRE ):
		anim_stri = 'Fire'
	elif ( animation == ANIM_IDLE ):
		anim_stri = 'Idle'
	elif ( animation == ANIM_DIE ):
		anim_stri = 'Death'
	var stri: String = anim_stri + dir_stri
	return stri
	
	
	
func _compute_dir():
	if not crosshair:
		return 0
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
	var Pistol = load( "res://gun/Pistol.gd" )
	var g = Pistol.new()
	guns.append( [ g ] )
	g.player = self
	g.hud    = hud
	g.active = true
	self.add_child( g )
	gun = g


func _process_firing():
	var just_pressed = Input.is_action_just_pressed( "ui_fire" )
	if just_pressed:
		if gun:
			gun.gun_shoot_start()
	else:
		var just_released = Input.is_action_just_released( "ui_fire" )
		if just_released and gun:
			gun.gun_shoot_stop()


func set_gun_sound( sound ):
	$AudioStreamPlayer.stream = sound
#func _on_gun_animation_stop():
#	anim = ANIM_FIRE
#	anim_fire_continuous = false
#	# Later on it will stop when animation finishes.


func hit( amount ):
	health -= amount
	var stri_state
	if ( amount <= 0 ):
		stri_state = "die"
	else:
		stri_state = "hit"
	$StateMachine.change_state( stri_state )


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.playing = false
	#print( "player sound finished" )
