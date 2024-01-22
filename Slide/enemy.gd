extends Area2D

signal killed

@export var speed = 20
@export var distance = 100
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += randi_range(0, speed) * delta
	position.y += randi_range(0, speed) * delta
	
	speed += 1 if direction == 0 else -1
	if abs(speed) >= distance:
		# Flip the bit
		direction ^= 1


func _on_body_entered(body):
	killed.emit()
	if body.name == "Player":
		body.hit.emit()
	body.queue_free()
	queue_free()

