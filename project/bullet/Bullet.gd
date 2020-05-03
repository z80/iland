
extends Node2D

var initialized: bool = false

var damage: int = 10
var instant: bool = false
var speed: float = 2000.0

var velocity: Vector2 = Vector2()
var max_distance: float = 1000.0
var distance: float = 0.0

var timer_interval: float = 0.3
var player = null
var has_hit_target: bool = false

var hit_sound: Resource = preload( "res://bullet/sounds/hit.ogg" )

# Call this after instantiation.
func initialize( start: Vector2, to: Vector2 ):
	var d = to - start
	d = d.normalized()
	# Bullet initial position
	position = start + d * 50.0
	
	# Sprite orientation.
	var angle = atan2( d.y, d.x )
	$Sprite.rotation = angle
	
	# Initiate velocity.
	if not instant:
		velocity = d.normalized() * speed
	else:
		velocity = d.normalized() * max_distance
		
	initialized = true


func _init():
	pass
	
func _ready():
	if hit_sound:
		hit_sound.set_loop( false )
		
	$Sprite.z_index = Game.LAYER_FLYING_OBJECT
	
	$RayCast2D.collide_with_areas  = true
	$RayCast2D.collide_with_bodies = false
	if instant:
		$Timer.wait_time = timer_interval
		$Timer.start()
		$Timer.connect( "timeout", self, "_on_Timer_timeout" )
		

func _physics_process( delta ):
	# If not initialized, do nothing.
	if not initialized:
		return
		
	if has_hit_target:
		return
	
	var new_pos: Vector2
	if not instant:
		distance += speed * delta
		new_pos = position + velocity * delta
	else:
		new_pos = position + velocity
	$RayCast2D.cast_to = new_pos - position
	position = new_pos
	var collides = $RayCast2D.is_colliding()
	if ( not collides ):
		if instant:
			queue_free()
		return
	var obj: Object = $RayCast2D.get_collider()
	
	# Get the owner.
	var owner = obj.owner
	if not owner:
		queue_free()
		return
	var has_hit: bool = owner.has_method( "hit" )
	if has_hit:
		owner.hit( damage, hit_sound )
		queue_free()
	
	# To not process it anymore
	has_hit_target = true
	

func _on_Timer_timeout():
	queue_free()
	

