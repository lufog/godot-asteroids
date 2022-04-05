class_name AsteroidTrailEffect
extends Node2D


@onready var particles := $Particles as GPUParticles2D
@onready var free_delay_timer := $FreeDelayTimer as Timer


func free_with_delay() -> void:
	particles.emitting = false
	free_delay_timer.start()
	@warning_ignore(redundant_await) # TODO: remove warning ignore after fix: https://github.com/godotengine/godot/issues/56265
	await free_delay_timer.timeout
	queue_free()
