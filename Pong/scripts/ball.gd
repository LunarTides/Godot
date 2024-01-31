extends CharacterBody2D

@export var speed: int

@export var bounce_up: Array[PhysicsBody2D]
@export var bounce_sideways: Array[PhysicsBody2D]

signal collided(collider: Object)

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ONE * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	velocity.x = speed * sign(velocity.x)
	velocity.y = speed * sign(velocity.y)
	
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		print_verbose("Collided with: ", collider.name)
		
		if collider in bounce_up:
			velocity.y = -velocity.y
		if collider in bounce_sideways:
			velocity.x = -velocity.x
		
		# Idk why we have to do this, but if we dont, the ball will get stuck to the floor.
		velocity.x += randi_range(0, round(speed / 2))
		velocity.y += randi_range(0, round(speed / 2))
		
		collided.emit(collider)
