class_name Laser extends Area2D

@export var speed := 600.0
@export var lifetime := 1.1

@onready var forward_direction := Vector2.UP.rotated(rotation)
@onready var lifetime_timer := $LifetimeTimer as Timer

func _ready() -> void:
	lifetime_timer.start(lifetime)

func _process(delta: float) -> void:
	position += forward_direction * speed * delta

func _on_lifetime_timer_timeout() -> void:
	destroy()

func _on_laser_body_entered(body: Node2D) -> void:
	var asteroid := body as Asteroid
	if asteroid:
		self.destroy()
		asteroid.destroy()

func destroy() -> void:
	queue_free()
