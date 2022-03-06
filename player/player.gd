extends CharacterBody2D

@export var move_speed: float = 300
@export var move_accel: float = 400
@export var move_decel: float = 100

@export var turn_speed: float = 3
@export var turn_accel: float = 6
@export var turn_decel: float = 2

var angular_velocity: float = 0


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_forward"):
		velocity = velocity.move_toward(-transform.y * move_speed, move_accel * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, move_decel * delta)
	
	var turn_direction := Input.get_axis("turn_left", "turn_right")
	if turn_direction != 0:
		angular_velocity = move_toward(angular_velocity, turn_direction * turn_speed, turn_accel * delta)
	else:
		angular_velocity = move_toward(angular_velocity, 0, turn_decel * delta)
	
	rotation += angular_velocity * delta
	move_and_slide()
