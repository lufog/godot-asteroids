class_name Asteroid extends RigidDynamicBody2D

var explosion_effect_scene := preload("res://effects/asteroid_explosion/asteroid_explosion.tscn")

# - Callbacks -----------------------------------------------------------------

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	Helpers.physics_body_screen_wrap(state)

# - Public --------------------------------------------------------------------

func destroy() -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	get_parent().add_child(explosion_effect)
	queue_free()
