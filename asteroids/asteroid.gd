class_name Asteroid extends RigidDynamicBody2D

var explosion_effect_scene := preload("res://effects/asteroid_explosion/asteroid_explosion.tscn")


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	Helpers.physics_body_screen_wrap(state)


func _spawn_explosion_effect(particles_scale: float) -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	explosion_effect.scale = Vector2.ONE * particles_scale
	get_parent().add_child(explosion_effect)


func destroy() -> void:
	queue_free()
