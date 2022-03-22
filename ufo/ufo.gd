extends RigidDynamicBody2D

var explosion_effect_scene := preload("res://effects/ship_explosion/ship_explosion.tscn")

@onready var laser_gun := $LaserGun as LaserGun

func _on_shoot_timer_timeout() -> void:
	laser_gun.shoot()


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	Helpers.physics_body_screen_wrap(state)


func destroy() -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	get_parent().add_child(explosion_effect)
	queue_free()

