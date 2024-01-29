extends Camera2D

var is_shaking: bool = false

func _on_gravestone_shake(amount, times, timer):
	if is_shaking:
		return
	
	# Shake the camera a bit
	shake(0, amount, times, timer)

func shake(depth, amount, times, timer):
	# If it has shaked enough times, leave
	if depth > times:
		is_shaking = false
		offset = Vector2.ZERO
		return
	
	is_shaking = true
	
	# Repeat until depth = shake_times
	var amount_to_shake = (amount if depth & 1 == 0 else -amount) * randi_range(1, 1 + (depth / 10))
	
	offset += Vector2(amount_to_shake * [1, -1].pick_random(), amount_to_shake * [1, -1].pick_random())
	get_tree().create_timer(timer).timeout.connect(func(): shake(depth + 1, amount, times, timer))
