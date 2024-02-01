extends Control

# Called when the node enters the scene tree for the first time.
func _process(_delta):
	update_points()
	update_health()

func update_points():
	$Points/Player1.text = "Points: %s" % Game.players[1].points
	$Points/Player2.text = "Points: %s" % Game.players[2].points

func update_health():
	$Health/Player1.text = "Health: %s" % Game.players[1].health
	$Health/Player2.text = "Health: %s" % Game.players[2].health
