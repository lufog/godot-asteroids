extends RigidDynamicBody2D

@onready var viewport_rect := get_viewport().get_visible_rect()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Screen wrap (editing position will directly break physics)
	state.transform.origin.x = wrapf(state.transform.origin.x, 0, viewport_rect.size.x)
	state.transform.origin.y = wrapf(state.transform.origin.y, 0, viewport_rect.size.y)
