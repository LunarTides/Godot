extends CharacterBody2D

@export var speed: int
@export var can_control: bool = false

@export var player1: bool = false

func _physics_process(_delta: float) -> void:
	if not can_control:
		return
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("player1_up" if player1 else "player2_up", "player1_down" if player1 else "player2_down")
	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
