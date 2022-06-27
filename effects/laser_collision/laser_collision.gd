extends Node2D


@onready var animated_sprite := $AnimatedSprite as AnimatedSprite2D


func _ready() -> void:
	animated_sprite.play("default")
	await animated_sprite.animation_finished
	queue_free()
