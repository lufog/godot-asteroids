class_name Thruster extends AnimatedSprite2D

@onready var thruster_sound := $ThrusterSound as AudioStreamPlayer2D

var active := false

func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	if active:
		visible = true
		play("thrust")
		if !thruster_sound.playing:
			thruster_sound.play()
	
	else:
		play("stop")
		# TODO: remove warning ignore after fix:
		# https://github.com/godotengine/godot/issues/56265
		@warning_ignore(redundant_await)
		await animation_finished
		thruster_sound.stop()
		visible = false
