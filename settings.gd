extends Node


var music_volume = 100
var sound_volume = 100


func _ready() -> void:
	load_from_file()


func load_from_file() -> void:
	print("load_settings")


func save_to_file() -> void:
	print("save_settings")
