class_name Projectile 
extends Area2D

@export var speed := 600.0
@export var lifetime := 1.1
@export var collosion_effect_scene: PackedScene

@onready var forward_direction := Vector2.UP.rotated(rotation)
@onready var lifetime_timer := $LifetimeTimer as Timer


func _ready() -> void:
	lifetime_timer.start(lifetime)


func _process(delta: float) -> void:
	position += forward_direction * speed * delta


func _on_lifetime_timer_timeout() -> void:
	queue_free()


func _on_laser_body_entered(body: Node2D) -> void:
	if body.has_method("destroy"):
		destroy()
		body.destroy()


func destroy() -> void:
	var collision_effect := collosion_effect_scene.instantiate() as Node2D
	collision_effect.position = position
	get_parent().add_child(collision_effect)
	queue_free()
