class_name Laser
extends Area2D


@export var speed := 100.0
@export var collision_effect_scene: PackedScene

@onready var sprite := $Sprite as Sprite2D
@onready var sprite_rect := sprite.get_rect()
@onready var forward_direction := Vector2.UP.rotated(rotation)


func _physics_process(delta: float) -> void:
	position += forward_direction * speed * delta
	position = Helpers.screen_wrap(position, sprite_rect.size)


func _on_lifetime_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("destroy"):
		body.destroy()
		destroy()


func destroy() -> void:
	_spawn_collision_effect()
	queue_free()


func _spawn_collision_effect() -> void:
	var collision_effect := collision_effect_scene.instantiate() as Node2D
	collision_effect.position = position
	get_parent().add_child(collision_effect)
