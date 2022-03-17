extends GPUParticles2D

@onready var explosion_sound := $AudioPlayer as AudioStreamPlayer2D

func _ready() -> void:
	# TODO: remove warning ignore after fix:
	# https://github.com/godotengine/godot/issues/56265
	@warning_ignore(redundant_await)
	await explosion_sound.finished
	queue_free()
