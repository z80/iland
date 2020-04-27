
extends Node2D

var instant: bool = true
var speed: float = 1000.0
var velocity: Vector2 = Vector2()
var max_distance: float = 1000.0
var distance: float = 0.0
var damage: float = 1.0

var timer_interval: float = 0.3
var player = null
var has_hit_target: bool = false

var hit_sound: Resource = preload( "res://bullet/sounds/hit.ogg" )

func _init( start: Vector2, dir: Vector2 ):
	position = start
	if not instant:
		velocity = dir.normalized() * speed
	else:
		velocity = dir.normalized() * max_distance
	
	
func _ready():
	$RayCast2D.collide_with_areas  = true
	$RayCast2D.collide_with_bodies = false
	if instant:
		$Timer.wait_time = timer_interval
		$Timer.start()
		

func _physics_process( delta ):
	if has_hit_target:
		return
	var new_pos: Vector2
	if not instant:
		distance += speed * delta
		new_pos = position + velocity * delta
	else:
		new_pos = position + velocity * distance
	$RayCast2D.cast_to( new_pos )
	var collides = $RayCast2D.is_colliding()
	if ( not collides ):
		return
	var obj: Object = $RayCast2D.get_collider()
	
	# Play the hit sound
	$AudioStreamPlayer.stream = hit_sound
	$AudioStreamPlayer.play()
	#var correct_type: bool = obj is Enemy
	#if correct_type:
	#	_hit_target( obj as Enemy )
	
func _hit_target( obj ):
	pass

func _on_Timer_timeout():
	queue_free()
