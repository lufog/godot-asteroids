extends RigidDynamicBody2D

var explosion_effect_scene := preload("res://effects/ship_explosion/ship_explosion.tscn")


func destroy() -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	get_parent().add_child(explosion_effect)
	queue_free()
