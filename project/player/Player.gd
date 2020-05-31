extends KinematicBody2D

const HEALTH: int = 100

export(int) var move_speed = 250
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

# Create all the guns
var guns = []
var gun = null
var gun_category = 0
var gun_index = 0
# Used by "fire" state
var gun_animation_speed: float = 1.0

var health setget set_health, get_health

var zoom: float = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	_demo_version_visibility()
	
	health = HEALTH
	# Make camera 2d current.
	$Camera2D.make_current()
	
	$AnimatedSpriteLower.z_index = Game.LAYER_CHARACTER
	$AnimatedSpriteUpper.z_index = Game.LAYER_CHARACTER+1
	
	# Make it play animation all the time.
	$AnimatedSpriteLower.playing = true
	$AnimatedSpriteUpper.playing = true
	
	var p = get_parent()
	# Create Crosshair.
	#var vp = get_tree().get_root()
	crosshair = Crosshair.instance()
	#vp.add_child( crosshair )
	p.add_child( crosshair )
	crosshair.player = self
	crosshair.visible = true
	
	_create_guns()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process( delta ):
	# Process firing
	_process_firing()


func _input( event ): 
	_process_zoom( event )


func set_health( val: int ):
	health = val
	$CanvasLayer/Health.set_health( health )


func get_health() -> int:
	return health

func add_health( d: int = 10 ):
	var h: int = health + d
	if h > HEALTH:
		h = HEALTH
	set_health( h )


func play_animation_lower( anim ):
	var d = _compute_dir()
	var stri = _animation_name( anim, d )
	var current_stri = $AnimatedSpriteLower.animation
	if current_stri != stri:
		$AnimatedSpriteLower.frame = 0
		$AnimatedSpriteLower.animation = stri
	if not $AnimatedSpriteLower.playing:
		$AnimatedSpriteLower.play()


func stop_animation_lower( frame=-1 ):
	$AnimatedSpriteLower.playing = false
	if frame >= 0:
		$AnimatedSpriteLower.frame = frame


func play_animation_upper( anim, same=false ):
	var d = _compute_dir()
	var stri = _animation_name( anim, d )
	var current_stri = $AnimatedSpriteUpper.animation
	if current_stri != stri:
		if not same:
			$AnimatedSpriteUpper.frame = 0
		else:
			$AnimatedSpriteUpper.frame = $AnimatedSpriteLower.frame
		$AnimatedSpriteUpper.animation = stri
	if not $AnimatedSpriteUpper.playing:
		$AnimatedSpriteUpper.play()


func stop_animation_upper( frame=-1 ):
	$AnimatedSpriteUpper.playing = false
	if frame >= 0:
		$AnimatedSpriteUpper.frame = frame


func play_sound( sound ):
	$AudioStreamPlayer.stream = sound
	$AudioStreamPlayer.play()


func change_state_lower( state_name ):
	# To change state from outside.
	# For example, by a gun.
	$StateMachineLower.change_state( state_name )


func change_state_upper( state_name ):
	# To change state from outside.
	# For example, by a gun.
	$StateMachineUpper.change_state( state_name )


func set_collision( en: bool ):
	$CollisionShape2D.disabled = not en


func state_machine_lower():
	return $StateMachineLower


func state_machine_upper():
	return $StateMachineUpper


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
	g.active = true
	self.add_child( g )
	gun = g


func _process_firing():
	if health <= 0:
		return
	
	if gun:
		var just_pressed = Input.is_action_just_pressed( "ui_fire" )
		if just_pressed:
			gun.gun_shoot_start()
		else:
			var just_released = Input.is_action_just_released( "ui_fire" )
			if just_released:
				gun.gun_shoot_stop()


func _process_zoom( event ):
	if event is InputEventMouseButton:
		# zoom in
		if (event.button_index == BUTTON_WHEEL_UP) and (zoom > 1.0):
			# call the zoom function
			zoom -= 0.1
			$Camera2D.zoom = Vector2( zoom, zoom )
		# zoom out
		if (event.button_index == BUTTON_WHEEL_DOWN) and (zoom < 2.25):
			# call the zoom function
			zoom += 0.1
			$Camera2D.zoom = Vector2( zoom, zoom )
			
	elif Input.is_action_just_pressed( "ui_zoom_in" ) and (zoom > 0.5):
			zoom -= 0.1
			$Camera2D.zoom = Vector2( zoom, zoom )
	elif Input.is_action_just_pressed( "ui_zoom_out" ) and (zoom < 2.25):
			zoom += 0.1
			$Camera2D.zoom = Vector2( zoom, zoom )
	
#func _on_gun_animation_stop():
#	anim = ANIM_FIRE
#	anim_fire_continuous = false
#	# Later on it will stop when animation finishes.


func hit( amount, hit_sound ):
	if health < 0:
		return
	
	set_health( health - amount )
	var stri_state
	if ( health <= 0 ):
		gun.gun_shoot_stop()
		$AnimatedSpriteLower.z_index = Game.LAYER_ON_FLOOR
		$AnimatedSpriteUpper.z_index = Game.LAYER_ON_FLOOR+1
		stri_state = "die"
		$StateMachineLower.change_state( stri_state )
		$StateMachineUpper.change_state( stri_state )
	else:
		#stri_state = "hit"
		if hit_sound:
			play_sound( hit_sound )


func is_player() -> bool:
	return true

func alive() -> bool:
	var res: bool = (health > 0)
	return res

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.playing = false
	#print( "player sound finished" )


func add_score( v: int ):
	if alive():
		$CanvasLayer/Health.add_score( v )


func set_score( v: int ):
	$CanvasLayer/Health.set_score( v )


func _demo_version_visibility():
	var d: bool = Globals.demo()
	$CanvasLayer/ItchDemo.visible = d


