extends RigidDynamicBody2D


var explosion_effect_scene := preload("res://effects/ship_explosion/ship_explosion.tscn")

@onready var weapon := $Weapon as Weapon
@onready var sprite := $Sprite as Sprite2D
@onready var sprite_rect := sprite.get_rect()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	Helpers.screen_wrap_physics_body(state, sprite_rect.size)


func _on_shoot_timer_timeout() -> void:
	weapon.shoot()


func destroy() -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	get_parent().add_child(explosion_effect)
	queue_free()

