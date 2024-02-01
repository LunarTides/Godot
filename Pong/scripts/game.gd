extends Node

signal lost_health(player_id: int, amount: int)
signal gained_points(player_id: int, amount: int)
signal reset_game

# Player 1 has 3 health, player 2 has 3 health
var players: Dictionary = {
	1: {
		"health": 3,
		"points": 0
	},
	2: {
		"health": 3,
		"points": 0
	}
}

func _ready() -> void:
	load_save()
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save()

func add_points(player_id: int, amount: int) -> void:
	players[player_id].points += amount
	print("Player %s's points: %s" % [player_id, players[player_id].points])
	
	gained_points.emit(player_id, amount)

func dmg(player_id: int, amount: int) -> void:
	players[player_id].health -= amount
	print("Player %s's health: %s" % [player_id, players[player_id].health])
	
	lost_health.emit(player_id, amount)
	
	# If the player dies, quit the game
	if players[player_id].health <= 0:
		print("Player %s is dead" % player_id)
		delete_save()
		reset()

func reset() -> void:
	players = {
		1: {
			"health": 3,
			"points": 0
		},
		2: {
			"health": 3,
			"points": 0
		}
	}
	
	reset_game.emit()
	
	print("Reset game")

func save() -> void:
	# Save the game
	var config: ConfigFile = ConfigFile.new()
	
	config.set_value("player1", "health", players[1].health)
	config.set_value("player1", "points", players[1].points)
	
	config.set_value("player2", "health", players[2].health)
	config.set_value("player2", "points", players[2].points)
	
	config.save("user://savegame.ini")
	
	print("Saved game")

func load_save() -> void:
	var config: ConfigFile = ConfigFile.new()
	config.load("user://savegame.ini")
	
	players[1].health = config.get_value("player1", "health", 3)
	players[1].points = config.get_value("player1", "points", 0)
	
	players[2].health = config.get_value("player2", "health", 3)
	players[2].points = config.get_value("player2", "points", 0)
	
	print("Loaded game")

func delete_save() -> void:
	var dir: DirAccess = DirAccess.open("user://")
	dir.remove("savegame.ini")
