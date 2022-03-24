extends RigidDynamicBody2D

@export var max_lives: int = 3
@export var thrust_force: float = 500
@export var turn_force: float = 1000

var explosion_effect_scene := preload("res://effects/ship_explosion/ship_explosion.tscn")

var _lives: int = 0
var lives:
	get:
		return _lives
	set(value):
		_lives = clamp(value, 0, max_lives)
		GameEvents.player_lives_changed.emit(_lives)
		
		if _lives == 0:
			GameEvents.player_died.emit()
			destroy()

@onready var weapon := $Weapon as Weapon
@onready var thruster_left  := $Thrusters/Left  as Thruster
@onready var thruster_right := $Thrusters/Right as Thruster


func _ready() -> void:
	lives = max_lives


# TODO: Remove after implementing player damage
func _input(event: InputEvent) -> void:
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_Q) and just_pressed:
		lives -= 1


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
	Helpers.physics_body_screen_wrap(state)


func destroy() -> void:
	var explosion_effect := explosion_effect_scene.instantiate() as Node2D
	explosion_effect.position = position
	get_parent().add_child(explosion_effect)
	queue_free() 
