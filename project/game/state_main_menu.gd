
extends "res://state_machine/state.gd"

var MainMenu = preload( "res://menus/2d_menu.tscn" )

var main_menu = null

func enter( new_state ):
	if not main_menu:
		main_menu = MainMenu.instance()
		#var vp = get_tree().get_root()
		#vp.add_child( main_menu )
		state_machine.game.add_child( main_menu )
		
	main_menu.state   = self
	main_menu.visible = true
	
	#state_machine.game.visible = false



func exit( destroy ):
	if destroy:
		main_menu.queue_free()
		main_menu = null
	else:
		main_menu.visible = false


func handle_input( event ):
	pass


func physics_update(_delta):
	pass


