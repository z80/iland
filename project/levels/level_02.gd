extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Player      = preload( "res://player/Player.tscn" )
var Zhlob       = preload( "res://enemies/zhlob/Zhlob.tscn" )
var SpiderBrain = preload( "res://enemies/spider_brain/spider_brain.tscn" )
var RfPrivate   = preload( "res://enemies/rf_private/rf_private.tscn" )

var player = null

const MIN_DIST: float = 500.0
const MAX_DIST: float = 1500.0
var   rnd = RandomNumberGenerator.new()
const ENEMY_PROB_MIN = 1.0/300.0
const ENEMY_PROB_MAX = 1.0/100.0
const ENEMY_PROB_PERIOD = 60.0
var   t: float = 0.0

const ATTEMPTS_QTY: int = 50

const TOTAL_ENEMIES_QTY: int = 100

var created_enemies_qty_: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	created_enemies_qty_ = 0
	
	var walls = get_node( "/root/Level00/TileMapWalls" )
	#var fl = get_node( "/root/level_00/TileMapFloor" )
	player = Player.instance()
	#walls.add_child( player )
	walls.add_child( player )
	player.set_position( Vector2( 100, 100 ) )
	player.visible = true
	Game.set_player( player )
	#print( get_tree().get_node('/root').name )
	
	#create_enemy_spider_brain()
	Game.play_music()


func _process( delta ):
	if t < ENEMY_PROB_PERIOD:
		t += delta
		if t > ENEMY_PROB_PERIOD:
			t = ENEMY_PROB_PERIOD
	var prob: float = ENEMY_PROB_MIN + (ENEMY_PROB_MAX - ENEMY_PROB_MIN) * t / ENEMY_PROB_PERIOD
	var p: float = rnd.randf()
	if (p < prob) and player and player.alive():
		create_enemy()
		
	var done: bool = check_for_success()
	if done:
		Game.set_next_level( "level_03" )
		Game.change_state( "done_menu" )


func create_enemy():
	if created_enemies_qty_ < TOTAL_ENEMIES_QTY:
		var p: float = rnd.randf()
		if p < 0.8:
			p = rnd.randf()
			if p < 0.7:
				create_enemy_zhlob()
			else:
				create_enemy_rf_private()
		else:
			create_enemy_spider_brain()
		# Count enemies
		created_enemies_qty_ += 1
		Game.inc_enemy_qty()

func check_for_success() -> bool:
	var all_released: bool = ( created_enemies_qty_ >= TOTAL_ENEMIES_QTY )
	var all_killed: bool = (Game.enemy_qty() < 1)
	var ok: bool = all_released and all_killed
	return ok
	

func create_enemy_zhlob():
	var walls = get_node( "/root/Level00/TileMapWalls" )
	var zhlob = Zhlob.instance()
	walls.add_child( zhlob )
	zhlob.set_position( Vector2( 1500, 100 ) )
	zhlob.visible = true
	# Make player visible for the zhlob instance.
	zhlob.target = player
	
	var at: Vector2 = enemy_position()
	zhlob.position = at



func create_enemy_rf_private():
	var walls = get_node( "/root/Level00/TileMapWalls" )
	var rf_private = RfPrivate.instance()
	walls.add_child( rf_private )
	rf_private.set_position( Vector2( 1500, 100 ) )
	rf_private.visible = true
	# Make player visible for the zhlob instance.
	rf_private.target = player
	
	var at: Vector2 = enemy_position()
	rf_private.position = at


func create_enemy_spider_brain():
	var walls = get_node( "/root/Level00/TileMapWalls" )
	var enemy = SpiderBrain.instance()
	walls.add_child( enemy )
	enemy.set_position( Vector2( 1500, 100 ) )
	enemy.visible = true
	# Make player visible for the zhlob instance.
	enemy.target = player
	
	var at: Vector2 = enemy_position()
	enemy.position = at


func enemy_position() -> Vector2:
	var attempts = 0
	var player_at: Vector2 = player.position
	
	var at: Vector2
	while attempts < ATTEMPTS_QTY:
		var dist: float = rnd.randf_range( MIN_DIST, MAX_DIST )
		var angle: float = rnd.randf_range( 0.0, PI*2.0 )
		var x: float  = cos(angle) * dist
		var y: float  = sin(angle) * dist
		at = Vector2( x, y )
		var d = (at - player_at).length()
		if d > MIN_DIST:
			break
	return at


