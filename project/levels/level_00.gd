extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Player = preload( "res://player/Player.tscn" )
var Zhlob  = preload( "res://enemies/zhlob/Zhlob.tscn" )

var player = null

const MIN_DIST: float = 1000.0
const MAX_DIST: float = 3000.0
var   rnd = RandomNumberGenerator.new()
const ENEMY_PROB_MIN = 1.0/300.0
const ENEMY_PROB_MAX = 1.0/100.0
const ENEMY_PROB_PERIOD = 60.0
var   t: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	var walls = get_node( "/root/Level00/TileMapWalls" )
	#var fl = get_node( "/root/level_00/TileMapFloor" )
	player = Player.instance()
	#walls.add_child( player )
	walls.add_child( player )
	player.set_position( Vector2( 100, 100 ) )
	player.visible = true
	#print( get_tree().get_node('/root').name )
	
	#var zhlob = Zhlob.instance()
	#walls.add_child( zhlob )
	#zhlob.set_position( Vector2( 1500, 100 ) )
	#zhlob.visible = true
	## Make player visible for the zhlob instance.
	#zhlob.target = player


func _process( delta ):
	if t < ENEMY_PROB_PERIOD:
		t += delta
		if t > ENEMY_PROB_PERIOD:
			t = ENEMY_PROB_PERIOD
	var prob: float = ENEMY_PROB_MIN + (ENEMY_PROB_MAX - ENEMY_PROB_MIN) * t / ENEMY_PROB_PERIOD
	var p: float = rnd.randf()
	if p < prob:
		create_enemy()


func create_enemy():
	var walls = get_node( "/root/Level00/TileMapWalls" )
	var zhlob = Zhlob.instance()
	walls.add_child( zhlob )
	zhlob.set_position( Vector2( 1500, 100 ) )
	zhlob.visible = true
	# Make player visible for the zhlob instance.
	zhlob.target = player
	
	var at: Vector2 = player.global_position
	
	var dist: float = rnd.randf_range( MIN_DIST, MAX_DIST )
	var angle: float = rnd.randf_range( 0.0, PI*2.0 )
	var x: float  = cos(angle) * dist
	var y: float  = sin(angle) * dist
	zhlob.position = at + Vector2(x, y)





