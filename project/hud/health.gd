extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func set_health_qty( qty ):
	var stri = "{:02d}".format( qty )
	$Health.text = stri
