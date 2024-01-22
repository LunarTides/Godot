extends Node2D

@export var tetromino_scene: PackedScene
@export var tetromino_shapes: Array[PackedScene]
var next_shape: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_tetromino()

func _on_tetromino_landed():
	spawn_tetromino()
	
func spawn_tetromino():
	# Spawn a new one
	var tetromino = tetromino_scene.instantiate()
	tetromino.remove_child(tetromino.get_node("Body"))
	
	var body: CharacterBody2D
	
	# Pick a random shape
	if not next_shape:
		body = tetromino_shapes.pick_random().instantiate()
	else:
		body = next_shape
	
	next_shape = tetromino_shapes.pick_random().instantiate()
	$NextShape.texture = next_shape.get_node("Sprite").texture
	
	body.name = "Body"
	tetromino.add_child(body)
	
	tetromino.body = body
	
	# Put around in the middle of the screen
	tetromino.position = Vector2(get_viewport().size.x / 2, 16 * 4)
	tetromino.landed.connect(_on_tetromino_landed)
	
	add_child(tetromino)


func _on_ceiling_body_entered(body):
	# Lose the game
	# TODO: Make this better. Maybe main menu?
	get_tree().quit()
