extends Control


var score_: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func set_health( qty ):
	if qty < 0:
		qty = 0
	var stri = "%2d" % qty
	$Health.text = stri


func set_score( v: int ):
	score_ = v
	var stri = "score: %5d" % score_
	$Score.text = stri


func add_score( v: int ):
	set_score( score_ + v )

