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
	crosshair = Crosshair.instance()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var v = Vector2()
	v.x -= 1 if Input.is_action_pressed( "ui_left" ) else 0
	v.x += 1 if Input.is_action_pressed( "ui_right" ) else 0
	v.y -= 1 if Input.is_action_pressed( "ui_up" ) else 0
	v.y += 1 if Input.is_action_pressed( "ui_down" ) else 0
	var anim = null
	if ( v.x != 0 ) and ( v.y != 0 ):
		anim = 'Idle_000'
	else:
		anim = 'Walk_000'
	$AnimatedSprite.animation = anim
	$AnimatedSprite.play()
	v.y *= 0.5
	v *= move_speed
	print( "v: ", v )
	move_and_slide( v )
	
