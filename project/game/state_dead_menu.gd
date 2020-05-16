
extends "res://state_machine/state.gd"

var DeadMenu = preload( "res://menus/dead_menu.tscn" )
var dead_menu = null


func enter( new_state ):
	.enter( new_state )
	if not dead_menu:
		dead_menu = DeadMenu.instance()
		var vp = get_tree().get_root()
		vp.add_child( dead_menu )
		
	dead_menu.state = self
	dead_menu.visible = true
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	var tree = get_tree()
	tree.paused = true


func exit( destroy ):
	if dead_menu:
		if destroy:
			dead_menu.queue_free()
			dead_menu = null
		else:
			dead_menu.visible = false
	var tree = get_tree()
	tree.paused = false








