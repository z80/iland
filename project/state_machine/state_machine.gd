extends Node
# Base interface for a generic state machine.
# It handles initializing, setting the machine active or not
# delegating _physics_process, _input calls to the State nodes,
# and changing the current/active state.
# See the PlayerV2 scene for an example on how to use it.

signal state_changed( current_state )

# You should set a starting node from the inspector or on the node that inherits
# from this state machine interface. If you don't, the game will default to
# the first state in the state machine's children.
export(String) var start_state_name
var states_map = {}

var states_stack = []
var current_state = null
var _active = false setget set_active

func _init_states_map( sm ):
	pass

func _ready():
	# Fill states map
	_init_states_map( states_map )
	
	# Connect signals.
	for child in get_children():
		child.connect( "finished", self, "_change_state" )
		states_map[child.name] = child
	
	if start_state_name in states_map:
		initialize( start_state_name )


func initialize( initial_state_name ):
	set_active( true )
	states_stack.push_back( states_map[initial_state_name] )
	current_state = states_stack.back()
	current_state.enter()


func set_active( value ):
	_active = value
	set_physics_process( value )
	set_process_input( value )
	if not _active:
		states_stack = []
		current_state = null


func _input( event ):
	current_state.handle_input( event )


func _physics_process( delta ):
	current_state.physics_update( delta )


func _on_animation_finished( anim_name ):
	if not _active:
		return
	current_state.on_animation_finished( anim_name )


func _change_state( state_name ):
	if not _active:
		return
	current_state.exit()

	#if state_name == "previous":
	var to_previous: bool = not (state_name in states_map )
	if to_previous:
		states_stack.pop_back()
	else:
		states_stack.push_back( states_map[state_name] )

	current_state = states_stack.back()
	emit_signal( "state_changed", current_state )

	if not to_previous:
		current_state.enter()



