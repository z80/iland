
extends "res://state_machine/state.gd"

func enter( new_state ):
	character.play_animation( character.ANIM_FIRE )


func on_animation_finished():
	var d = character.target_dist()
	if d < character.fire_distance:
		var target = character.target
		if not target:
			target = Game.player()
			character.target = target
		elif  not target.alive():
			target = Game.player()
			character.target = target

		target.hit( 25, null )
		var has_set_target: bool = target.has_method( "set_target" )
		if has_set_target:
			target.set_target( character )
	
	state_machine.change_state( "prev" )
