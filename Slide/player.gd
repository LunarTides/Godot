extends CharacterBody2D

signal hit

var target = Vector2()
var recoil_amount = 0

func _physics_process(delta):
	# Look at the mouse
	target = get_global_mouse_position()
	look_at(target)
	
	# Slow down over time
	recoil_amount = max(recoil_amount / 1.01, 0)
	#velocity = Vector2(move_toward(velocity.x, 0, 1), move_toward(velocity.y, 0, 1))
	move_and_slide()


func _unhandled_key_input(event):
	if event.is_action_pressed("shoot"):
		$Gun.shoot()
		
		print("Shoot")


func recoil(amount):
	recoil_amount += amount
	var direction = (target - transform.origin).normalized()
	velocity = -(direction * recoil_amount)
	rotation = velocity.angle()


func _on_visible_on_screen_notifier_2d_screen_exited():
	hit.emit()
	queue_free()
