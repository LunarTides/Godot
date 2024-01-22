extends Node2D

signal recoil

@export var bullet_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func shoot():
	recoil.emit(100)
	
	var bullet = bullet_scene.instantiate()
	
	bullet.start(global_position, get_global_mouse_position())
	
	get_tree().get_root().get_node("Main").add_child(bullet)
