class_name Laser extends Area2D

@onready var forward_direction := Vector2.UP.rotated(rotation)

var speed := 600.0

func _process(delta: float) -> void:
	position += forward_direction * speed * delta

func _on_laser_body_entered(body: Node2D) -> void:
	if body is Asteroid:
		body.destroy()

func destroy() -> void:
	queue_free()
