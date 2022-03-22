class_name DebrisSpawner extends Node2D

@export var debris_scene: PackedScene
@export var directions: Array[Vector2]
@export var offset := 10.0
@export var force := 50.0


func spawn() -> void:
	for i in directions.size():
		var debris = debris_scene.instantiate() as Asteroid
		debris.global_position = global_position + (directions[i] * offset)
		debris.angular_velocity = randf_range(-4, 4)
		debris.linear_velocity = directions[i] * force
		get_parent().get_parent().add_child(debris)
