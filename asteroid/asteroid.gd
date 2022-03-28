class_name Asteroid extends RigidDynamicBody2D

@export var asteroid_type: Resource = asteroid_type as AsteroidType

var debris_scene := load("res://asteroid/asteroid.tscn") as PackedScene
var explosion_effect_scene := load("res://effects/asteroid_explosion/asteroid_explosion.tscn") as PackedScene

@onready var sprite := $Sprite as Sprite2D
@onready var collision_shape := $CollisionShape as CollisionShape2D


func _ready() -> void:
	sprite.texture = asteroid_type.texture
	collision_shape.shape = asteroid_type.shape


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	Helpers.physics_body_screen_wrap(state)


func _spawn_single_debris(debris_type_index: int, debris_velosity: Vector2) -> void:
	var debris := debris_scene.instantiate() as Asteroid
	debris.asteroid_type = asteroid_type.debris_types[debris_type_index]
	debris.position = position
	debris.linear_velocity  = debris_velosity
	get_parent().add_child.call_deferred(debris)
	
	
func _spawn_all_debris() -> void:
	if (asteroid_type.debris_count == 0):
		# There is nothing to spawn
		return
	
	if (asteroid_type.debris_count == 1):
		# One debris, assign the same linear_velocity to it
		var rand_type_index := randi_range(0, asteroid_type.debris_types.size() - 1)
		_spawn_single_debris(rand_type_index, linear_velocity)
	
	else:
		# More than one debris, calculate deflected linear_velocity for each
		var direction := linear_velocity.normalized()
		var direction_angle := direction.angle()
		var deflection_angle = PI / (asteroid_type.debris_count - 1)
		
		for i in asteroid_type.debris_count:
			var rand_type_index := randi_range(0, asteroid_type.debris_types.size() - 1)
			var deflection := Vector2.UP.rotated(direction_angle + deflection_angle * i)
			var debris_velosity := (direction + deflection).normalized() * linear_velocity.length()
			_spawn_single_debris(rand_type_index, debris_velosity)


func _spawn_explosion_effect() -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	get_parent().add_child(explosion_effect)


func destroy() -> void:
	_spawn_all_debris()
	_spawn_explosion_effect()
	queue_free()
