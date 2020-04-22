extends MarginContainer


signal hud_gun_icon
signal hud_ammo_qty

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_hud_gun_icon( resource ):
	$HBoxContainer/GunIcon.texture = resource
	
func _on_hud_ammo_qty( qty ):
	var stri = "{:02d}".format( qty )
	$HBoxContainer/Ammo.text = stri
