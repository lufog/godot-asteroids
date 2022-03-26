class_name DebrisSpawner extends Node2D

@export var debris_scene: PackedScene
@export var directions: Array[Vector2]
@export var offset := 10.0
@export var force := 50.0

const random_rotation := 4.0
const random_direction_deviation := 0.5

@onready var asteroids_node := $/root/Main/Asteroids as Node


func _calculate_deviated_direction(direction_index: int) -> Vector2:
	var deviation := Vector2(
		randf_range(-random_direction_deviation, random_direction_deviation),
		randf_range(-random_direction_deviation, random_direction_deviation)
	)
	return directions[direction_index] + deviation


func spawn() -> void:
	for i in directions.size():
		var debris = debris_scene.instantiate() as Asteroid
		debris.global_position = global_position + (directions[i] * offset)
		debris.angular_velocity = randf_range(-random_rotation, random_rotation)
		debris.linear_velocity = _calculate_deviated_direction(i) * force
		asteroids_node.add_child.call_deferred(debris)
