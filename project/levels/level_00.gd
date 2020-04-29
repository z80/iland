extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Player = preload( "res://player/Player.tscn" )
var Zhlob  = preload( "res://enemies/zhlob/Zhlob.tscn" )


# Called when the node enters the scene tree for the first time.
func _ready():
	var walls = get_node( "/root/level_00/TileMapWalls" )
	#var fl = get_node( "/root/level_00/TileMapFloor" )
	var player = Player.instance()
	#walls.add_child( player )
	walls.add_child( player )
	player.set_position( Vector2( 100, 100 ) )
	player.visible = true
	#print( get_tree().get_node('/root').name )
	
	var zhlob = Zhlob.instance()
	walls.add_child( zhlob )
	zhlob.set_position( Vector2( 1500, 100 ) )
	zhlob.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
