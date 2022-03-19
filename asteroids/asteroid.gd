class_name Asteroid extends RigidDynamicBody2D

var explosion_effect_scene := preload("res://effects/asteroid_explosion/asteroid_explosion.tscn")

@onready var viewport_rect := get_viewport().get_visible_rect()

# Callbacks -------------------------------------------------------------------

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Screen wrap
	state.transform.origin.x = wrapf(state.transform.origin.x, 0.0, viewport_rect.size.x)
	state.transform.origin.y = wrapf(state.transform.origin.y, 0.0, viewport_rect.size.y)

# Public methods --------------------------------------------------------------

func destroy() -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	get_parent().add_child(explosion_effect)
	queue_free()
