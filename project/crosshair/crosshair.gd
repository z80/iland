extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$SpriteRed.visible = false
	$SpriteGreen.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Place cursor where mouse position is
	var at = get_viewport().get_mouse_position()
	position = at
