extends Node2D

@onready var particles := $Particles as GPUParticles2D
@onready var sfx := $SFX as AudioStreamPlayer2D;

func _ready() -> void:
	particles.emitting = true
	# TODO: remove warning ignore after fix: https://github.com/godotengine/godot/issues/56265
	@warning_ignore(redundant_await)
	await sfx.finished
	queue_free()
