class_name Weapon extends Node2D


@export var _laser_scene: PackedScene

var _can_shoot := true

@onready var _root_node := $/root as Node
@onready var _cooldown_timer := $CooldownTimer as Timer


func _on_cooldown_timer_timeout() -> void:
	_can_shoot = true


func shoot() -> void:
	if _can_shoot:
		var laser := _laser_scene.instantiate() as Laser
		laser.global_position = global_position
		laser.global_rotation = global_rotation
		_root_node.add_child(laser)
		
		_can_shoot = false
		_cooldown_timer.start()
