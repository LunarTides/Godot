extends Node2D

var click_times: int = 0
var is_shaking = false

@export var click_amount: int = 5
@export var shake_amount: int = 5
@export var shake_times: int = 5
@export var shake_timer: float = 0.05
@export var particle_timer: float = 0.1

signal shake(shake_amount: int, shake_times: int, shake_timer: float)

func _on_button_button_down():
	# If it's already shaking, don't start shaking again
	if is_shaking:
		return
	
	# Play particles (It is a one shot)
	$HitParticles.restart()
	
	# Play sound effect
	$Hit.pitch_scale = randf_range(0.5, 1.0)
	$Hit.play()
	
	# Internal counter
	click_times += 1
	
	# If the player clicked enough times, close the game
	if click_times >= click_amount:
		get_tree().quit()
		return
	
	do_shake()

func do_shake(depth: int = 0):
	# If it has shaked enough times, leave
	if depth > shake_times:
		is_shaking = false
		return
	
	# Emit the shake signal
	if depth == 0:
		shake.emit(shake_amount, shake_times, shake_timer)
	
	is_shaking = true
	
	# Move the gravestone a little bit to the right, then move it a little to the left.
	# Repeat until depth = shake_times
	position.x += shake_amount if depth & 1 == 0 else -shake_amount
	get_tree().create_timer(shake_timer).timeout.connect(func(): do_shake(depth + 1))
