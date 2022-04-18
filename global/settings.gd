extends Node


enum _BusIdx { MASTER = 0, MUSIC = 1, SOUND = 2 }

const settings_file_path = "user://settings.dat"

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
	load_from_file()


func load_from_file() -> void:
	var file := File.new()
	if file.open(settings_file_path, File.READ) == OK:
		# File opened, load data from file
		master_volume = file.get_float()
		music_volume = file.get_float()
		sound_volume = file.get_float()
		file.close()
	else:
		# Failed to open file, set defaults
		master_volume = 1.0
		music_volume = 1.0
		sound_volume = 1.0


func save_to_file() -> void:
	var file := File.new()
	if file.open(settings_file_path, File.WRITE) == OK:
		# File opened, save data to file
		file.store_float(master_volume)
		file.store_float(music_volume)
		file.store_float(sound_volume)
		file.close()
