
class_name Gun

extends Node

signal gun_animation_start( speed_scale )


# Reference to the player
var player
var hud

# When cycling through inventory to know whichone to activate.
var category: int = 0
var index: int = 0

var available: bool  = false setget set_available, get_available
var active: bool = false setget set_active, get_active

var icon: Texture  = null
var sound: Resource = null
var shoot_interval = 0.3
var shoot_elapsed  = 0.3
#var shoot_sound: Sound = null
var shooting: bool = false
var automatic: bool = false

func _init():
	player = null
	hud = null
	print( "End of Gun.gd::_init()" )
	
	
func _physics_process( delta ):
	if ( shoot_elapsed < shoot_interval ):
		shoot_elapsed += delta
	if not shooting:
		return
	if ( shoot_elapsed >= shoot_interval ):
		# Create bullet here. And send command to play shoot animation.
		var speed_scale = 1.0 / shoot_interval
		player.gun_animation_start( speed_scale )
		shoot_elapsed -= shoot_interval
		
		# Stop shooting if it is not a machine gun.
		if not automatic:
			shooting = false
		
		# Create bullet
		# ...

func set_available( en: bool ):
	available = en
	
func get_available() -> bool:
	var en = available
	return en

func set_active( en: bool ):
	active = en
	if en and player:
		hud.set_gun_icon( icon )
		player.set_gun_sound( sound )
	
func get_active() -> bool:
	var en = active
	return en


#func _on_gun_activate():
#	pass
	
func gun_shoot_start():
	shooting = true
	
func gun_shoot_stop():
	# Stops shooting in the case of automatic machine gun fire.
	shooting = false
	player.gun_animation_stop()

#func _on_gun_switch():
#	pass
