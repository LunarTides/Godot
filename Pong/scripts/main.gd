extends Node2D

@export var ball: CharacterBody2D

@export var left_paddle: CharacterBody2D
@export var right_paddle: CharacterBody2D

@export var player1_paddles: Array[CharacterBody2D]
@export var player2_paddles: Array[CharacterBody2D]

@export var player1_wall: StaticBody2D
@export var player2_wall: StaticBody2D

var can_be_hit = true
var can_gain_points = true

@onready var screen_size: Vector2 = get_viewport().size

# Called when the node enters the scene tree for the first time.
func _ready():
	# Move the ball and paddles to the right place
	ball.position = screen_size / 2
	
	left_paddle.position.x = 8
	left_paddle.position.y = screen_size.y / 2
	
	right_paddle.position.x = screen_size.x - 8
	right_paddle.position.y = screen_size.y / 2
	
	$LeftPaddleGhost.position = left_paddle.position
	$RightPaddleGhost.position = right_paddle.position

func _process(_delta):
	# Keep the ghosts at the correct x position so they won't be moved by the ball riding glitch, but they can still bounce the ball
	$LeftPaddleGhost.position.x = 8
	$RightPaddleGhost.position.x = screen_size.x - 8

func _on_ball_collided(collider: Object):
	if collider == player1_wall:
		dmg(1, 1)
	elif collider == player2_wall:
		dmg(2, 1)
	elif collider is CharacterBody2D:
		if collider in player1_paddles:
			add_points(1, 1)
		elif collider in player2_paddles:
			add_points(2, 1)

func dmg(player_id: int, amount: int):
	if not can_be_hit:
		return
	
	Game.dmg(player_id, amount)
	
	can_be_hit = false
	$HitCooldown.start()

func add_points(player_id: int, amount: int):
	if not can_gain_points:
		return
	
	Game.add_points(player_id, amount)
	
	can_gain_points = false
	$PointsCooldown.start()

func _on_hit_cooldown_timeout():
	can_be_hit = true

func _on_points_cooldown_timeout():
	can_gain_points = true
