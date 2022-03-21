extends RigidDynamicBody2D

var explosion_effect_scene := preload("res://effects/ship_explosion/ship_explosion.tscn")

@onready var animation := $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	animation.play("default")
	pass


func destroy() -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	get_parent().add_child(explosion_effect)
	queue_free()
