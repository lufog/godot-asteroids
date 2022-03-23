class_name AsteroidSmall extends Asteroid


func destroy() -> void:
	_spawn_explosion_effect(0.5)
	super.destroy()
