
class_name Gun

extends Node

signal gub_animation_start( speed_scale )

# Category in which it resides.
enum Category {CAT_1=0, CAT_2=1, CAT_3=2};

var player
var available: bool  = false setget set_available, get_available
var active: bool = false setget set_active, get_active
var icon: Texture  = null
var shoot_interval = 0.3
var shoot_elapsed  = 0.3
#var shoot_sound: Sound = null
var shooting: bool = false
var automatic: bool = false

func _init():
	player = null
	connect( "gun_shoot_start", self, self._on_gun_shoot_start )
	connect( "gun_shoot_end",   self, self._on_gun_shoot_end )
	pass
	
	
func _physics_process( delta ):
	if ( shoot_elapsed < shoot_interval ):
		# Create bullet here. And send command to play shoot animation.
		var speed_scale = 1.0 / shoot_interval
		emit_signal( "gun_animation_start", speed_scale )
		pass

func set_available( en: bool ):
	available = en
	
func get_available() -> bool:
	var en = available
	return en

func set_active( en: bool ):
	active = en
	
func get_active() -> bool:
	var en = active
	return en


#func _on_gun_activate():
#	pass
	
func _on_gun_shoot_start():
	if ( active ):
		shooting = true
	
func _on_gun_shoot_end():
	shooting = false
	
#func _on_gun_switch():
#	pass
