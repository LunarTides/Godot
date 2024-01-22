extends CharacterBody2D

var target = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_slide()
	
	
func start(starting_position, mouse_pos):
	position = starting_position
	
	target = mouse_pos.normalized() * 100
	
	velocity.x = target.x
	velocity.y = target.y


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_enemy_body_entered(body):
	queue_free()
