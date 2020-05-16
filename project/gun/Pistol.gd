
extends Gun

class_name Pistol

#var Gun = load("res://Gun/Gun.gd")



func _init():
	# It calls this _init() automatically.
	#._init()
	#icon = load("res://Gun/Pistol.png")
	shoot_interval = 0.1
	shoot_elapsed  = 0.1
	automatic      = true
	index    = 0
	category = 0
	#print( "end of Pistol.gd::_init()" )







