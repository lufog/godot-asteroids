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
		@warning_ignore(redundant_await) # TODO: remove warning ignore after fix: https://github.com/godotengine/godot/issues/56265
		await animation_finished
		sfx.stop()
		visible = false
