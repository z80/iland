
extends "res://state_machine/state_machine.gd"

enum {LAYER_FLOOR=0, LAYER_ON_FLOOR=1, LAYER_CHARACTER=2, LAYER_FLYING_OBJECT=3}

var player_ = null
var rnd_ = RandomNumberGenerator.new()
var enemy_qty_: int = 0
var next_level_state_: String = "prev"
var score_: int = 0

func _init_states_map( sm ):
	._init_states_map( sm )
	sm["main_menu"]  = $StateMainMenu
	sm["pause_menu"] = $StatePauseMenu
	sm["done_menu"]  = $StateDoneMenu
	sm["level_00"]   = $StateLevel00
	sm["level_01"]   = $StateLevel01
	sm["level_02"]   = $StateLevel02
	sm["level_03"]   = $StateLevel03
	sm["dead"]       = $StateDead
	# Debug states
	sm["d_main_menu"] = $StateDMainMenu
	sm["d_level"] = $StateDLevel
	
	#start_state_name = "main_menu"
	start_state_name = "main_menu"



func random_generator():
	return rnd_



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



func set_player( p ):
	player_ = p
	if p:
		player_.set_score( score_ )


func player():
	return player_


func set_score( v: int = 0 ):
	score_ = v
	if player_:
		player_.set_score( score_ )


func add_score( v: int = 0 ):
	set_score( score_ + v )
	if player_:
		player_.set_score( score_ )


func inc_enemy_qty():
	enemy_qty_ += 1


func dec_enemy_qty():
	enemy_qty_ -= 1


func enemy_qty() -> int:
	return enemy_qty_;


func reset_enemy_qty():
	enemy_qty_ = 0



func set_next_level( s: String ):
	next_level_state_ = s



func next_level() -> String:
	return next_level_state_






