extends RigidDynamicBody2D

@export var thrust_force: float = 300
@export var turn_force: float = 400

@onready var viewport_rect := get_viewport().get_visible_rect()
@onready var thruster_left  := $Thrusters/ThrusterLeft  as Thruster
@onready var thruster_right := $Thrusters/ThrusterRight as Thruster

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
		
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Screen wrap (editing position will directly break physics)
	state.transform.origin.x = wrapf(state.transform.origin.x, 0, viewport_rect.size.x)
	state.transform.origin.y = wrapf(state.transform.origin.y, 0, viewport_rect.size.y)
