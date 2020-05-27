
extends Node2D

var initialized: bool = false

var damage: int = 10
var instant: bool = false
var speed: float = 600.0

var velocity: Vector2 = Vector2()
var max_distance: float = 1000.0
var distance: float = 0.0

var timer_interval: float = 2.0
var character = null
var has_hit_target: bool = false

var hit_sound: Resource = preload( "res://enemies/spider_brain/sounds/hit.ogg" )

# Call this after instantiation.
func initialize( origin, start: Vector2, to: Vector2 ):
	character = origin
	
	var d = to - start
	d = d.normalized()
	# Bullet initial position
	position = start + d * 128.0
	
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

	$Timer.wait_time = timer_interval
	$Timer.start()


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
	var has_hit: bool   = owner.has_method( "hit" )
	var is_player: bool = owner.has_method( "is_player" )
	var has_set_target: bool = owner.has_method( "set_target" )
	if has_hit and (owner != character):
		owner.hit( damage, hit_sound )
		if has_set_target:
			owner.set_target( character )
		queue_free()
	

func _on_Timer_timeout():
	queue_free()
	

