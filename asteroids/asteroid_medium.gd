class_name AsteroidMedium extends Asteroid

@onready var debris_spawner := $DebrisSpawner as DebrisSpawner


func destroy() -> void:
	debris_spawner.spawn()
	_spawn_explosion_effect(0.75)
	super.destroy()
