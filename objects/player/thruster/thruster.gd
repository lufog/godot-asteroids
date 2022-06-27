class_name Thruster 
extends Node2D


var active := false

@onready var animated_sprite := $AnimatedSprite as AnimatedSprite2D
@onready var sfx := $SFX as AudioStreamPlayer2D


func _process(_delta: float) -> void:
	if active:
		animated_sprite.play("ignition")
		if !sfx.playing:
			sfx.play()
	else:
		animated_sprite.play("extinction")
		await animated_sprite.animation_finished
		sfx.stop()
