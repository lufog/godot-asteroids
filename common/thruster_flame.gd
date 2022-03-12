extends AnimatedSprite2D
class_name Thruster

var active := false

func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	if active:
		visible = true
		play("thrust")
	else:
		play("stop")
		@warning_ignore(redundant_await)
		await animation_finished
		visible = false
