extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.gained_points.connect(on_game_gained_points)
	Game.lost_health.connect(on_game_lost_health)
	
	update_points()
	update_health()

func on_game_gained_points(_player_id: int, _amount: int):
	update_points()

func on_game_lost_health(_player_id: int, _amount: int):
	update_health()

func update_points():
	$Points/Player1.text = "Points: %s" % Game.player_points[1]
	$Points/Player2.text = "Points: %s" % Game.player_points[2]

func update_health():
	$Health/Player1.text = "Health: %s" % Game.player_health[1]
	$Health/Player2.text = "Health: %s" % Game.player_health[2]
