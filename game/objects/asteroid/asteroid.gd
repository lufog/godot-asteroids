class_name Asteroid
extends RigidDynamicBody2D


@export var score_poins := 0
@export var debris_amount := 0
@export var debris_scenes: Array[PackedScene]
@export var debris_velosity_multiplier := 1.5
@export var effects_scale := 1.0

const angular_velocity_range := 1.0

var trail_effect_scene := preload("./effects/trail/asteroid_trail_effect.tscn") as PackedScene
var explosion_effect_scene := preload("./effects/explosion/asteroid_explosion_effect.tscn") as PackedScene
var trail_effect: AsteroidTrailEffect

@onready var sprite := $Sprite as Sprite2D
@onready var sprite_rect := sprite.get_rect()


func _ready() -> void:
	_spawn_trail_effect()


func _physics_process(_delta: float) -> void:
	trail_effect.position = position


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	Helpers.screen_wrap_physics_body(state, sprite_rect.size)


func _on_body_entered(body: Node) -> void:
	if body.has_method("destroy"):
		body.destroy()


func destroy() -> void:
	GameEvents.score_points_added.emit(score_poins)
	
	_spawn_debris()
	_spawn_explosion_effect()
	
	trail_effect.free_with_delay()
	queue_free()


func _spawn_single_debris(direction: Vector2) -> void:
	var index := randi_range(0, debris_scenes.size() - 1)
	var debris := debris_scenes[index].instantiate() as Asteroid
	var new_velocity = direction * linear_velocity.length() * debris_velosity_multiplier
	debris.position = position
	debris.linear_velocity = new_velocity
	debris.angular_velocity = randf_range(-angular_velocity_range, angular_velocity_range)
	get_parent().add_child.call_deferred(debris)


func _spawn_debris() -> void:
	if (debris_amount == 0):
		# There is nothing to spawn
		return
	
	if (debris_amount == 1):
		# One debris, assign the same linear_velocity to it
		var new_direction := linear_velocity.normalized()
		_spawn_single_debris(new_direction)
	
	else:
		# More than one debris, calculate deflected linear_velocity for each
		var direction := linear_velocity.normalized()
		var direction_angle := direction.angle()
		var deflection_angle = PI / (debris_amount - 1)
		
		for i in debris_amount:
			var deflection := Vector2.UP.rotated(direction_angle + deflection_angle * i)
			var new_direction := (direction + deflection).normalized()
			_spawn_single_debris(new_direction)


func _spawn_trail_effect() -> void:
	trail_effect = trail_effect_scene.instantiate() as AsteroidTrailEffect
	get_parent().add_child.call_deferred(trail_effect)
	trail_effect.scale = Vector2.ONE * effects_scale


func _spawn_explosion_effect() -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	explosion_effect.scale = Vector2.ONE * effects_scale
	get_parent().add_child.call_deferred(explosion_effect)
