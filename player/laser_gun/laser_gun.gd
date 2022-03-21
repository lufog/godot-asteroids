class_name LaserGun extends Node2D

var projectile_scene := load("res://projectiles/laser_green/laser_green.tscn") as PackedScene
var can_shoot := true

@onready var root_node := $/root as Node
@onready var cooldown_timer := $CooldownTimer as Timer


func _on_cooldown_timer_timeout() -> void:
	can_shoot = true


func shoot() -> void:
	if can_shoot:
		var projectile := projectile_scene.instantiate() as Projectile
		projectile.global_position = global_position
		projectile.global_rotation = global_rotation
		root_node.add_child(projectile)
		
		can_shoot = false
		cooldown_timer.start()
