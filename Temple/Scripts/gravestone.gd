extends Node2D

var click_times: int = 0
var is_shaking = false

@export var click_amount: int = 5
@export var shake_amount: int = 5
@export var shake_times: int = 5
@export var shake_timer: float = 0.05

func _on_button_button_down():
	if is_shaking:
		return
	
	$Hit.pitch_scale = randf_range(0.5, 1.0)
	$Hit.play()
	click_times += 1
	
	if click_times >= click_amount:
		get_tree().quit()
		return
	
	shake()

func shake(depth: int = 0):
	if depth > shake_times:
		is_shaking = false
		return
	
	is_shaking = true
	
	position.x += shake_amount if depth & 1 == 0 else -shake_amount
	get_tree().create_timer(shake_timer).timeout.connect(func(): shake(depth + 1))
