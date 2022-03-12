class_name Laser extends Area2D

var speed: float = 600.0
var forward_direction

func _ready() -> void:
	forward_direction = Vector2.UP.rotated(rotation)

func _process(delta: float) -> void:
	position += forward_direction * speed * delta

func destroy() -> void:
	queue_free()
