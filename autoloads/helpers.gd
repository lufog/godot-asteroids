extends Node


@onready var viewport_rect := get_viewport().get_visible_rect()


func screen_wrap(position: Vector2) -> Vector2:
	position.x = wrapf(position.x, 0.0, viewport_rect.size.x)
	position.y = wrapf(position.y, 0.0, viewport_rect.size.y)
	return position


func screen_wrap_physics_body(state: PhysicsDirectBodyState2D):
	state.transform.origin.x = wrapf(state.transform.origin.x, 0.0, viewport_rect.size.x)
	state.transform.origin.y = wrapf(state.transform.origin.y, 0.0, viewport_rect.size.y)
