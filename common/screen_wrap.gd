extends Node

@onready var parent_node := get_parent() as Node2D
@onready var viewport_rect := get_viewport().get_visible_rect()

func _process(_delta: float) -> void:
	parent_node.position.x = wrapf(parent_node.position.x, 0, viewport_rect.size.x)
	parent_node.position.y = wrapf(parent_node.position.y, 0, viewport_rect.size.y)
