
class_name Gun

extends Node

signal gun_animation_start( speed_scale )

var Shell  = preload( "res://bullet/Shell.tscn" )
var Bullet = preload( "res://bullet/Bullet.tscn" )

# Reference to the player
var player
var hud

# When cycling through inventory to know whichone to activate.
var category: int = 0
var index: int = 0

var available: bool  = false setget set_available, get_available
var active: bool = false setget set_active, get_active

var icon: Texture  = null
# Shot sound
var shot_sound: Resource = preload( "res://gun/sounds/m4.ogg" )
var shoot_interval = 0.3
var shoot_elapsed  = 0.3
#var shoot_sound: Sound = null
var shooting: bool = false
var automatic: bool = false


func _init():
	player = null
	hud = null
	print( "End of Gun.gd::_init()" )

func _ready():
	shot_sound.set_loop( false )
	
func _physics_process( delta ):
	if ( shoot_elapsed < shoot_interval ):
		shoot_elapsed += delta
	if not shooting:
		return
	if ( shoot_elapsed >= shoot_interval ):
		# Create bullet here. And send command to play shoot animation.
		var speed_scale = 1.0 / shoot_interval
		player.gun_animation_speed = speed_scale
		player.change_state( "fire" )
		player.play_sound( shot_sound )
		_create_shell()
		shoot_elapsed -= shoot_interval
		
		# Stop shooting if it is not a machine gun.
		if not automatic:
			shooting = false
		
		# Create bullet
		var vp = get_tree().get_root()
		var bullet = Bullet.instance()
		vp.add_child( bullet )
		bullet.visible = true
		bullet.initialize( player.position, player.crosshair.position )
		
		
func set_available( en: bool ):
	available = en
	
func get_available() -> bool:
	var en = available
	return en

func set_active( en: bool ):
	active = en
	#if en and player:
		#hud.set_gun_icon( icon )
		#player.set_gun_sound( shot_sound )
	
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
	
func _create_shell():
	var dir_stri: String = player._animation_dir_name( player._compute_dir() )
	var shell = Shell.instance()
	var p = self.player.get_parent() #get_tree().get_root()
	p.add_child( shell )
	shell.sample( dir_stri )
	shell.position = player.position
	
#func _on_gun_switch():
#	pass
