extends RigidDynamicBody2D

@export var max_lives: int = 3
@export var thrust_force: float = 400
@export var turn_force: float = 600

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

@onready var viewport_rect := get_viewport().get_visible_rect()
@onready var laser_gun := $LaserGun as LaserGun
@onready var thruster_left  := $Thrusters/Left  as Thruster
@onready var thruster_right := $Thrusters/Right as Thruster

# Callbacks -------------------------------------------------------------------

func _ready() -> void:
	lives = max_lives

# TODO: Remove after implementing player gamage
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
		laser_gun.shoot()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Screen wrap
	state.transform.origin.x = wrapf(state.transform.origin.x, 0.0, viewport_rect.size.x)
	state.transform.origin.y = wrapf(state.transform.origin.y, 0.0, viewport_rect.size.y)

# Public methods --------------------------------------------------------------

func destroy() -> void:
	queue_free() 
