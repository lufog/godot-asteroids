class_name AsteroidMedium extends Asteroid


@onready var debris_spawner := $DebrisSpawner as DebrisSpawner


func destroy() -> void:
	debris_spawner.spawn()
	super.destroy()
