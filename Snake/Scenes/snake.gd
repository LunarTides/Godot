extends CharacterBody2D

const SPEED = 300.0
var direction: Vector2

@export var path: Path2D
@export var path_follow: PathFollow2D
@export var tail: Sprite2D

func _physics_process(delta):
	velocity = direction * SPEED
	
	path.curve.clear_points()
	path.curve.add_point(tail.position)
	path.curve.add_point(position)
	
	path_follow.progress_ratio = 0.1
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if vector:
		if vector.x != 0 and vector.y != 0:
			vector = Vector2(vector.x, 0)
		
		direction = vector.normalized()

	move_and_slide()
