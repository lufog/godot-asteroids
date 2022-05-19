extends Node
class_name AsteroidSpawner


@export var initial_number := 4
@export var extra_per_level := 1
@export var asteroid_scenes: Array[PackedScene]


func spawn_asteroids() -> void:
	for i in initial_number:
		_spawn_single_asteroid()


func _spawn_single_asteroid() -> void:
	var index := randi_range(0, asteroid_scenes.size() - 1)
	var asteroid := asteroid_scenes[index].instantiate() as Asteroid
	add_child(asteroid)
	
	asteroid.position = Helpers.get_screen_center()
	
	var move_direction := Vector2(randf_range(-1, 1), randf_range(-1, 1))
	var move_speed := randf_range(30, 100)
	asteroid.linear_velocity = move_direction * move_speed
	
	var rotate_direction: float = [-1.0, 1.0][randi_range(0, 1)]
	var rotate_speed := randf_range(0.5, 1.0)
	asteroid.angular_velocity = rotate_direction * rotate_speed
