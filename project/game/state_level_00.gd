
extends "res://game/state_active.gd"

var Level = preload( "res://levels/level_00.tscn" )
var level = null

func enter( new_state ):
	.enter( new_state )
	
	level.state   = self
	level.visible = true

func exit( destroyed ):
	.exit( destroyed )

func handle_input(event):
	.handle_input( event )


func physics_update(_delta):
	pass

