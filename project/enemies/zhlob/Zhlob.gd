extends KinematicBody2D

export(int)   var move_speed = 500
export(float) var fire_period   = 2.0
export(float) var fire_distance = 256.0
export(float) var sight_distance = 10000.0
export(int)   var health = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum {ANIM_IDLE=0, ANIM_WALK=1, ANIM_FIRE=2, ANIM_HIT=3, ANIM_DEATH=4}
enum {DIR_000=0, DIR_045=1, DIR_090=2, DIR_135=3, DIR_180=4, DIR_225=5, DIR_270=6, DIR_315=7}
enum {STATE_IDLE=0, STATE_WALK=1, STATE_HIT=2, STATE_FIRE=3, STATE_DYING=4, STATE_DEAD=5}

export(int)  var anim = ANIM_IDLE
export(int)  var anim_prev = ANIM_IDLE
#export(bool) var anim_fire_continuous = false
export(int)  var anim_dir  = DIR_000

var state: int = STATE_IDLE
var state_prev: int = STATE_IDLE
var target: KinematicBody2D = null
var line_of_sight: Vector2 = Vector2()
var finished_animation: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	target = null
	
func _process_state():
	var new_state = state
	if ( state == STATE_IDLE ):
		new_state = _process_idle()
	elif ( state == STATE_WALK ):
		new_state = _process_walk()
	elif ( state == STATE_HIT ):
		new_state = _process_hit()
	elif ( state == STATE_FIRE ):
		new_state = _process_fire()
	elif ( state == STATE_DYING ):
		new_state = _process_dying()
	elif ( state == STATE_DEAD ):
		new_state = _process_dead()
		
	if ( new_state == state ):
		return
	
	state = new_state
	if ( state == STATE_IDLE ):
		new_state = _to_idle()
	elif ( state == STATE_WALK ):
		new_state = _to_walk()
	elif ( state == STATE_HIT ):
		new_state = _to_hit()
	elif ( state == STATE_FIRE ):
		new_state = _to_fire()
	elif ( state == STATE_DYING ):
		new_state = _to_dying()
	elif ( state == STATE_DEAD ):
		new_state = _to_dead()
		
func _process_idle():
	var d = _target_dist()
	if d <= sight_distance:
		if d > fire_distance:
			var target_at = target.global_position
			var own_at = global_position
			var dv = target_at - own_at
			line_of_sight = dv
			return STATE_WALK
		else:
			return STATE_HIT
	
func _process_walk():
	if not target:
		return STATE_IDLE
		
	var target_at = target.global_position
	var own_at = global_position
	var dv = target_at - own_at
	line_of_sight = dv
	var d = dv.abs()
	if ( d <= fire_distance ):
		return STATE_FIRE
		
	return STATE_WALK
	
	
func _process_hit():
	if finished_animation:
		return state_prev
	return STATE_HIT

func _process_fire():
	if finished_animation:
		var d = _target_dist()
		if ( d <= fire_distance ):
			target.hit()
		return state_prev
		
	return STATE_FIRE
	
func _process_dying():
	if finished_animation:
		return STATE_DEAD
	return STATE_DYING
	
func _process_dead():
	return STATE_DEAD
	
func _to_idle():
	pass
	
func _to_walk():
	pass
	
func _to_hit():
	pass
	
func _to_fire():
	pass
	
func _to_dying():
	pass
	
func _to_dead():
	pass
	
	
func _target_dist():
	if not target:
		return fire_distance * 10
	var target_at = target.global_position
	var own_at = global_position
	var dv = target_at - own_at
	var d = dv.abs()
	return d

func _physics_process(delta):
	# Process moving
	var v: Vector2 = _process_moving()
	v.y *= 0.707107
	v *= move_speed
	var actual_v = move_and_slide( v )



func _process_moving():
	var v = Vector2()
	v.x -= 1 if Input.is_action_pressed( "ui_left" ) else 0
	v.x += 1 if Input.is_action_pressed( "ui_right" ) else 0
	v.y -= 1 if Input.is_action_pressed( "ui_up" ) else 0
	v.y += 1 if Input.is_action_pressed( "ui_down" ) else 0
	var new_anim = null
	
	if ( anim != ANIM_FIRE ):
		if ( v.x != 0 ) or ( v.y != 0 ):
			new_anim = ANIM_WALK
		else:
			new_anim = ANIM_IDLE
	var update_animation = false
	var new_dir = _compute_dir()
	if ( anim_dir != new_dir ):
		update_animation = true
		anim_dir = new_dir
	if ( update_animation or (anim != new_anim) ):
		anim = new_anim
		var stri: String = _animation_name( anim, anim_dir )
		$AnimatedSprite.animation = stri
	return v
	
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
	else:
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
	

func hit( damage=10 ):
	health -= damage
	if health > 0:
		state = STATE_HIT
		_to_hit()
	else:
		state = STATE_DYING
		_to_dying()


func _on_AnimatedSprite_animation_finished():
	finished_animation = true
