class_name LaserGun extends Node2D

@onready var root_node := get_tree().root as Node
@onready var cooldown_timer := $CooldownTimer as Timer

var laser_scene := load("res://laser/laser.tscn") as PackedScene
var can_shoot := true

func shoot():
	if can_shoot:
		var laser := laser_scene.instantiate() as Laser
		laser.global_position = global_position
		laser.global_rotation = global_rotation
		root_node.add_child(laser)
		
		can_shoot = false
		cooldown_timer.start()

func _on_cooldown_timer_timeout() -> void:
	can_shoot = true
