
extends "res://state_machine/state.gd"

var Shell  = preload( "res://bullet/Shell.tscn" )
var Bullet = preload( "res://enemies/spider_brain/bullet.tscn" )
var shot_sound: Resource = preload( "res://gun/sounds/m4.ogg" )


var fire_period: float = 1.0
var fire_elapsed: float = fire_period

func _ready():
	shot_sound.set_loop( false )


func enter( new_state ):
	character.play_animation( character.ANIM_FIRE )
	_shoot()


func on_animation_finished():
	var d = character.target_dist()
	if d > character.fire_distance:
		state_machine.change_state( "prev" )
	else:
		_shoot()


func _shoot():
	var target = character.target
	if target == null:
		target = Game.player()
		character.target = target
	elif not target.alive():
		target = Game.player()
		character.target = target
	
	var target_at = target.global_position
	var own_at = character.global_position
	var dv = target_at - own_at
	character.line_of_sight = dv
	character.play_animation( character.ANIM_FIRE )
	
	character.play_sound( shot_sound )
	_create_shell()
	_create_bullet()
	


func _create_bullet():
	var p = character.get_parent()
	var bullet = Bullet.instance()
	p.add_child( bullet )
	bullet.visible = true
	bullet.initialize( character, character.position, character.target.position )


func _create_shell():
	var dir_stri: String = character._animation_dir_name( character._compute_dir() )
	var shell = Shell.instance()
	var p = character.get_parent()
	p.add_child( shell )
	shell.sample( dir_stri )
	shell.position = character.position

