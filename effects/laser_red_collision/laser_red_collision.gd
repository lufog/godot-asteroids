extends Node2D

@onready var animated_sprite := $AnimatedSprite as AnimatedSprite2D


func _ready() -> void:
	animated_sprite.play("default")
	@warning_ignore(redundant_await) # TODO: remove warning ignore after fix: https://github.com/godotengine/godot/issues/56265
	await animated_sprite.animation_finished
	queue_free()
