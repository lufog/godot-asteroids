extends Node

@onready var parent_node := get_parent() as Node2D
@onready var viewport := get_viewport() as Viewport
@onready var screen_size := viewport.get_visible_rect().size

func _process(_delta: float) -> void:
	parent_node.position.x = wrapf(parent_node.position.x, 0, screen_size.x)
	parent_node.position.y = wrapf(parent_node.position.y, 0, screen_size.y)
