extends Node

@onready var viewport_rect := get_viewport().get_visible_rect()

func physics_body_screen_wrap(state: PhysicsDirectBodyState2D):
	state.transform.origin.x = wrapf(state.transform.origin.x, 0.0, viewport_rect.size.x)
	state.transform.origin.y = wrapf(state.transform.origin.y, 0.0, viewport_rect.size.y)
