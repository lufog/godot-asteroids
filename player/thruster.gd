class_name Thruster extends Node2D

var active: bool = false

@onready var thruster_flame := $ThrusterFlame as AnimatedSprite2D


func _ready() -> void:
	thruster_flame.visible = false

func _process(_delta: float) -> void:
	if active:
		thruster_flame.visible = true
		thruster_flame.play("thrust")
	else:
		thruster_flame.play("stop")
		@warning_ignore(redundant_await)
		await thruster_flame.animation_finished
		thruster_flame.visible = false
