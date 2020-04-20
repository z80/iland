extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Player = preload( "res://player/Player.tscn" )


# Called when the node enters the scene tree for the first time.
func _ready():
	var walls = get_node( "/root/level_00/TileMapWalls" )
	var player = Player.instance()
	walls.add_child( player )
	player.set_position( Vector2( 100, 100 ) )
	player.visible = true
	#print( get_tree().get_node('/root').name )


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
