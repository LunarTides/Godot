extends Node

signal lost_health(player_id: int, amount: int)
signal gained_points(player_id: int, amount: int)

# Player 1 has 3 health, player 2 has 3 health
var player_health: Dictionary = {1: 3, 2: 3}
var player_points: Dictionary = {1: 0, 2: 0}

func add_points(player_id: int, amount: int):
	player_points[player_id] += amount
	print("Player %s's points: %s" % [player_id, player_points[player_id]])
	
	gained_points.emit(player_id, amount)

func dmg(player_id: int, amount: int):
	player_health[player_id] -= amount
	print("Player %s's health: %s" % [player_id, player_health[player_id]])
	
	lost_health.emit(player_id, amount)
	
	# If the player dies, quit the game
	if player_health[player_id] <= 0:
		print("Player %s is dead" % player_id)
		get_tree().quit()
