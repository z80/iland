extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$SpriteRed.visible = false
	$SpriteGreen.visible = true
	$SpriteRed.z_index   = Game.LAYER_FLYING_OBJECT
	$SpriteGreen.z_index = Game.LAYER_FLYING_OBJECT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Place cursor where mouse position is
	var at = get_global_mouse_position()
	position = at


func _on_Crosshair_area_entered(area):
	$SpriteRed.visible   = true
	$SpriteGreen.visible = false


func _on_Crosshair_area_exited(area):
	$SpriteRed.visible   = false
	$SpriteGreen.visible = true
