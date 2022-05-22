extends RigidDynamicBody2D
class_name Player


@export var thrust_force: float = 2500
@export var turn_force: float = 5000

var explosion_effect_scene := preload("res://effects/ship_explosion/ship_explosion.tscn")

@onready var weapon := $Weapon as Weapon
@onready var thruster_left  := $Thrusters/ThrusterLeft  as Thruster
@onready var thruster_right := $Thrusters/ThrusterRight as Thruster
@onready var sprite := $Sprite as Sprite2D
@onready var sprite_rect := sprite.get_rect()


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("move_forward"):
		thruster_left.active  = true
		thruster_right.active = true
		
		var forward_direction = Vector2.UP.rotated(rotation)
		apply_force(forward_direction * thrust_force)
	else:
		thruster_left.active  = false
		thruster_right.active = false
	
	var turn_direction := Input.get_axis("turn_left", "turn_right")
	if turn_direction != 0:
		thruster_left.active  = turn_direction > 0
		thruster_right.active = turn_direction < 0
		
		apply_torque(turn_direction * turn_force)
	
	if Input.is_action_pressed("shoot"):
		weapon.shoot()


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	Helpers.screen_wrap_physics_body(state, sprite_rect.size)


func _on_body_entered(body: Node) -> void:
	if body.has_method("destroy"):
		body.destroy()


func destroy() -> void:
	if not is_queued_for_deletion():
		GameEvents.player_died.emit()
		_spawn_explosion_effect()
		queue_free()


func _spawn_explosion_effect() -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	get_parent().add_child(explosion_effect)
