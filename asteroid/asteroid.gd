class_name Asteroid
extends RigidDynamicBody2D


@export var debris_amount: int = 0
@export var debris_scenes: Array[PackedScene]

const angular_velocity_range := 1.0
var explosion_effect_scene := preload("res://effects/asteroid_explosion/asteroid_explosion.tscn") as PackedScene


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	Helpers.screen_wrap_physics_body(state)


func destroy() -> void:
	_spawn_debris()
	_spawn_explosion_effect()
	queue_free()


func _spawn_single_debris(new_velosity: Vector2) -> void:
	var index := randi_range(0, debris_scenes.size() - 1)
	var debris := debris_scenes[index].instantiate() as Asteroid
	debris.position = position
	debris.linear_velocity = new_velosity
	debris.angular_velocity = randf_range(-angular_velocity_range, angular_velocity_range)
	get_parent().add_child.call_deferred(debris)


func _spawn_debris() -> void:
	if (debris_amount == 0):
		# There is nothing to spawn
		return
	
	if (debris_amount == 1):
		# One debris, assign the same linear_velocity to it
		_spawn_single_debris(linear_velocity)
	
	else:
		# More than one debris, calculate deflected linear_velocity for each
		var direction := linear_velocity.normalized()
		var direction_angle := direction.angle()
		var deflection_angle = PI / (debris_amount - 1)
		
		for i in debris_amount:
			var deflection := Vector2.UP.rotated(direction_angle + deflection_angle * i)
			var new_velosity := (direction + deflection).normalized() * linear_velocity.length()
			_spawn_single_debris(new_velosity)


func _spawn_explosion_effect() -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	get_parent().add_child.call_deferred(explosion_effect)
