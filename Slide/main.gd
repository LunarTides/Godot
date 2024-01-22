extends Node2D

@export var enemy_scene: PackedScene
var score = 0
var running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not running:
		if Input.is_action_just_pressed("shoot"):
			get_tree().reload_current_scene()


func start():
	$EnemyTimer.start()
	running = true


func end():
	$EnemyTimer.stop()
	
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	running = false
	

func _on_enemy_timer_timeout():
	# Spawn an enemy.
	var enemy = enemy_scene.instantiate()
	
	var path_follow = $EnemyPath/PathFollow2D
	path_follow.progress_ratio = randf()
	
	enemy.position = path_follow.position;
	
	add_child(enemy)


func _on_player_hit():
	end()
