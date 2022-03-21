extends AnimatedSprite2D

# Callbacks -------------------------------------------------------------------

func _ready() -> void:
	playing = true
	# TODO: remove warning ignore after fix:
	# https://github.com/godotengine/godot/issues/56265
	@warning_ignore(redundant_await)
	await animation_finished
	queue_free()
