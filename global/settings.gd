extends Node


enum _BusIdx { MASTER = 0, MUSIC = 1, SOUND = 2 }

var _master_volume: float
var master_volume:
	get:
		return _master_volume
	set(value):
		_master_volume = value
		AudioServer.set_bus_volume_db(_BusIdx.MASTER, linear2db(value))

var _music_volume: float
var music_volume:
	get:
		return _music_volume
	set(value):
		_music_volume = value
		AudioServer.set_bus_volume_db(_BusIdx.MUSIC, linear2db(value))

var _sound_volume: float
var sound_volume:
	get:
		return _sound_volume
	set(value):
		_sound_volume = value
		AudioServer.set_bus_volume_db(_BusIdx.SOUND, linear2db(value))


func _ready() -> void:
	master_volume = 1
	music_volume = 1
	sound_volume = 1
	load_from_file()


func load_from_file() -> void:
	print("load_settings")


func save_to_file() -> void:
	print("save_settings")
