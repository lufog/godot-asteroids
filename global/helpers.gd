extends Node


@onready var viewport_rect := get_viewport().get_visible_rect()


func get_screen_center() -> Vector2:
	return viewport_rect.size / 2


func screen_wrap(position: Vector2, size: Vector2) -> Vector2:
	var half_size = size / 2
	position.x = wrapf(position.x, -half_size.x, viewport_rect.size.x + half_size.x)
	position.y = wrapf(position.y, -half_size.y, viewport_rect.size.y + half_size.y)
	return position


func screen_wrap_physics_body(state: PhysicsDirectBodyState2D, size: Vector2):
	var half_size = size / 2
	state.transform.origin.x = wrapf(state.transform.origin.x, -half_size.x, 
			viewport_rect.size.x + half_size.x)
	state.transform.origin.y = wrapf(state.transform.origin.y, -half_size.y, 
			viewport_rect.size.y + half_size.y)
