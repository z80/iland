
extends "res://state_machine/state_machine.gd"

enum {LAYER_FLOOR=0, LAYER_ON_FLOOR=1, LAYER_CHARACTER=2, LAYER_FLYING_OBJECT=3}


func _init_states_map( sm ):
	._init_states_map( sm )
	sm["main_menu"]  = $StateMainMenu
	sm["pause_menu"] = $StatePauseMenu
	sm["level_00"]   = $StateLevel00
	sm["dead"]       = $StateDead
	# Debug states
	sm["d_main_menu"] = $StateDMainMenu
	sm["d_level"] = $StateDLevel
	
	#start_state_name = "main_menu"
	start_state_name = "main_menu"
	
	


func find_node_by_name( name, root=null ):
	if not root:
		root = get_tree().get_root()
	
	if root.get_name() == name:
		return root

	var children: Array = root.get_children()
	for child in children:
		if child.get_name() == name:
			return child

		var found = find_node_by_name( name, child )

		if found:
			return found

	return null


