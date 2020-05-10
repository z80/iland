extends Node2D


enum { SZ_SMALL=0, SZ_MEDIUM=1, SZ_LARGE=2 }
const HEALTH_SMALL: int  = 25
const HEALTH_MEDIUM: int = 50
const HEALTH_LARGE: int  = 75

var sz_: int = SZ_SMALL


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.z_index = Game.LAYER_CHARACTER
	
	var rnd = Game.random_generator()
	
	if not rnd:
		sz_ = SZ_SMALL
	else:
		sz_ = rnd.randi() % 3
		
	# Scale the sprite size apropriately
	if sz_ == SZ_SMALL:
		$AnimatedSprite.scale = Vector2( 0.5, 0.5 )
	elif sz_ == SZ_MEDIUM:
		$AnimatedSprite.scale = Vector2( 0.75, 0.75 )
	elif sz_ == SZ_LARGE:
		$AnimatedSprite.scale = Vector2( 1.0, 1.0 )



func _on_Area2D_area_entered( area ):
	var obj = area.owner
	var is_player: bool = obj.has_method( "is_player" )
	if is_player:
		if sz_ == SZ_SMALL:
			obj.add_health( HEALTH_SMALL )
		elif sz_ == SZ_MEDIUM:
			obj.add_health( HEALTH_MEDIUM )
		elif sz_ == SZ_LARGE:
			obj.add_health( HEALTH_LARGE )
		# Remove medikit.
		queue_free()



