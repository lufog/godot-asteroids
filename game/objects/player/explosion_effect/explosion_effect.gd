extends Node2D


@onready var particles := $Particles as GPUParticles2D
@onready var sfx := $SFX as AudioStreamPlayer2D


func _ready() -> void:
	particles.emitting = true
	await sfx.finished
	queue_free()
