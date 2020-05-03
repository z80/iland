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

var character = null

func _init_states_map( sm ):
	pass

func _ready():
	# Fill states map
	_init_states_map( states_map )
	
	# Connect signals.
	for name in states_map.keys():
		var child = states_map[name]
		child.character     = character
		child.state_machine = self
	
	if start_state_name in states_map:
		initialize( start_state_name )


func initialize( initial_state_name ):
	set_active( true )
	states_stack.push_back( states_map[initial_state_name] )
	current_state = states_stack.back()
	current_state.enter( true )


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


func _on_animation_finished():
	if not _active:
		return
	#print( "StateMachine::_on_animation_finished()" )
	current_state.on_animation_finished()


# This one is called by states to either pop current one ot push another one..
func change_state( state_name=null, purge=false ):
	if not _active:
		return
	#if state_name == "previous":
	var to_previous: bool = not (state_name in states_map )
	
	
	# The new state to switch to.
	var new_state = null
	if not to_previous:
		new_state = states_map[state_name]
		
	if purge:
		# Clean up all the states
		# with removing content.
		var qty: int = states_stack.size()
		for i in range(qty):
			var ind: int = qty - i - 1
			var state = states_stack[ind]
			if state != new_state:
				state.exit( true )
		states_stack.clear()
		# Keep only the one to be used.
		states_stack.push_back( new_state )
	else:
		# Depending on if it is put on stack or removed completely
		current_state.exit( to_previous )
		
		if to_previous:
			states_stack.pop_back()
		else:
			states_stack.push_back( new_state )

	current_state = states_stack.back()
	emit_signal( "state_changed", current_state )

	current_state.enter( not to_previous )



