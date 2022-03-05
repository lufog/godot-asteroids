extends CharacterBody2D

@export var move_speed: float = 200
@export var move_accel_step: float = 400
@export var move_decel_step: float = 100

@export var turn_speed: float = 4
@export var turn_accel_step: float = 8
@export var turn_decel_step: float = 2

var angular_velocity: float = 0


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_forward"):
		velocity = velocity.move_toward(-transform.y * move_speed, move_accel_step * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, move_decel_step * delta)
	
	var turn_direction := Input.get_axis("turn_left", "turn_right")
	if turn_direction != 0:
		angular_velocity = move_toward(angular_velocity, turn_direction * turn_speed, turn_accel_step * delta)
	else:
		angular_velocity = move_toward(angular_velocity, 0, turn_decel_step * delta)
	
	rotation += angular_velocity * delta
	move_and_slide()
