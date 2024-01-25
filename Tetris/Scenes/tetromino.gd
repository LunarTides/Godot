extends Node2D

@export var body: CharacterBody2D
@export var fall_speed: int = 16
@export var drop_speed: int = 64
@export var move_speed: int = 16
@export var grid_space: int = 16

var actual_fall_speed: int
var can_control = true

signal landed

func _physics_process(delta):
	if not can_control:
		return
	
	# Cant use Input.getAxis since that updates the rotation every frame
	if Input.is_action_just_pressed("rotate_left"):
		body.rotate(deg_to_rad(-90))
	elif Input.is_action_just_pressed("rotate_right"):
		body.rotate(deg_to_rad(90))
	
	if Input.is_action_pressed("drop"):
		actual_fall_speed = drop_speed
	else:
		actual_fall_speed = fall_speed


func _on_timer_timeout():
	# Move left / right
	if not can_control:
		$Timer.stop()
		return
	
	body.velocity = Vector2.ZERO
		
	var velocity_x = Input.get_axis("move_left", "move_right")
	
	if velocity_x:
		body.velocity.x = velocity_x * move_speed
	else:
		# Move down
		body.velocity.y = actual_fall_speed
	
	var collision = body.move_and_collide(body.velocity)
	
	var position_x_rounded = floori(body.position.x)
	var position_y_rounded = floori(body.position.y)
	
	# Wtf
	if position_x_rounded % grid_space != 0:
		body.position.x = get_closest_multiple(position_x_rounded, grid_space)
	elif position_y_rounded % grid_space != 0:
		body.position.y = get_closest_multiple(position_y_rounded, grid_space)
	
	if collision:
		if collision.get_collider().is_in_group("Tetromino") or collision.get_collider().is_in_group("Ground"):
			can_control = false
			landed.emit()

func get_closest_multiple(n: int, x: int) -> int:
	# https://math.stackexchange.com/a/3056363
	return n if x == 0 else floori( ( n / x ) + 0.5 ) * x
