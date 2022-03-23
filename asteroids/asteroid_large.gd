class_name AsteroidLarge extends Asteroid

@onready var debris_spawner := $DebrisSpawner as DebrisSpawner


func destroy() -> void:
	debris_spawner.spawn()
	_spawn_explosion_effect(1.0)
	super.destroy()
