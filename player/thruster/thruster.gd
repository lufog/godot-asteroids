class_name Thruster extends AnimatedSprite2D

var active := false

@onready var sfx := $SFX as AudioStreamPlayer2D


func _ready() -> void:
	visible = false


func _process(_delta: float) -> void:
	if active:
		visible = true
		play("thrust")
		if !sfx.playing:
			sfx.play()
	else:
		play("stop")
		# TODO: remove warning ignore after fix:
		# https://github.com/godotengine/godot/issues/56265
		@warning_ignore(redundant_await)
		await animation_finished
		sfx.stop()
		visible = false
