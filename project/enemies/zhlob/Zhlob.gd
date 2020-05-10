extends KinematicBody2D

export(int)   var move_speed = 500
export(float) var fire_period   = 2.0
export(float) var fire_distance = 384.0
export(float) var sight_distance = 10000.0
export(int)   var health = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum {ANIM_IDLE=0, ANIM_WALK=1, ANIM_FIRE=2, ANIM_HIT=3, ANIM_DIE=4}
enum {DIR_000=0, DIR_045=1, DIR_090=2, DIR_135=3, DIR_180=4, DIR_225=5, DIR_270=6, DIR_315=7}
enum {STATE_IDLE=0, STATE_WALK=1, STATE_HIT=2, STATE_FIRE=3, STATE_DIE=4, STATE_DEAD=5}

export(int)  var anim = ANIM_IDLE
export(int)  var anim_prev = ANIM_IDLE
#export(bool) var anim_fire_continuous = false
export(int)  var anim_dir  = DIR_000

var Player = preload("res://player/Player.gd")

var state: int = STATE_IDLE
var state_prev: int = STATE_IDLE
var target = null
var line_of_sight: Vector2 = Vector2()
var finished_animation: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	target = null
	$AnimatedSprite.z_index = Game.LAYER_CHARACTER
	
	
func target_dist():
	if not target:
		return sight_distance * 10
	var target_at = target.global_position
	var own_at = global_position
	var dv = target_at - own_at
	var d = dv.length()
	return d

	
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
	elif ( animation == ANIM_HIT ):
		var ind: int = randi() % 3
		if ind == 0:
			anim_stri = "Hit_0"
		elif ind == 1:
			anim_stri = "Hit_1"
		else:
			anim_stri = "Hit_2"
	elif ( animation == ANIM_DIE ):
		anim_stri = 'Death'
	elif( animation == ANIM_IDLE ):
		anim_stri = 'Idle'
	var stri: String = anim_stri + dir_stri
	return stri
	
func _compute_dir():
	var a = line_of_sight
	var angle = atan2( a.y, a.x )
	var _pi_4 = PI*0.25
	var d = int(round( angle / _pi_4 ))
	if ( d < 0 ):
		d += 8
	return d
	
func play_animation( animation ):
	var dir = _compute_dir()
	var name = _animation_name( animation, dir )
	var current_name = $AnimatedSprite.animation
	if ( current_name != name ):
		print( "Current: ", current_name, ", new: ", name )
		$AnimatedSprite.frame = 0
		$AnimatedSprite.animation = name
		$AnimatedSprite.play()

func stop_animation( frame = -1 ):
	$AnimatedSprite.playing = false
	if frame >= 0:
		$AnimatedSprite.frame = frame
	
func play_sound( sound ):
	$AudioStreamPlayer.stream = sound
	$AudioStreamPlayer.play()

func hit( damage=10, hit_sound=null ):
	if health < 0:
		return
		
	health -= damage
	if health > 0:
		play_sound( hit_sound )
		if $StateMachine.current_state != $Hit:
			$StateMachine.change_state( "hit" )
	else:
		if $StateMachine.current_state != $Die:
			$AnimatedSprite.z_index = Game.LAYER_ON_FLOOR
			$Area2D.monitorable = false
			$Area2D.collision_layer = 0
			$StateMachine.change_state( "die" )


func set_collision( en: bool ):
	$CollisionShape2D.disabled = not en


func set_target( t ):
	target = t


