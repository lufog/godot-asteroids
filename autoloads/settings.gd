extends Node


enum _BusIdx { MASTER = 0, MUSIC = 1, SOUND = 2 }

const SETTINGS_FILE_PATH = "user://settings.dat"

var master_volume: float:
	get:
		return master_volume
	set(value):
		master_volume = value
		AudioServer.set_bus_volume_db(_BusIdx.MASTER, linear2db(value))

var music_volume: float:
	get:
		return music_volume
	set(value):
		music_volume = value
		AudioServer.set_bus_volume_db(_BusIdx.MUSIC, linear2db(value))

var sound_volume: float:
	get:
		return sound_volume
	set(value):
		sound_volume = value
		AudioServer.set_bus_volume_db(_BusIdx.SOUND, linear2db(value))


func _ready() -> void:
	load_from_file()


func load_from_file() -> void:
	var file := File.new()
	if file.open(SETTINGS_FILE_PATH, File.READ) == OK:
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
	if file.open(SETTINGS_FILE_PATH, File.WRITE) == OK:
		# File opened, save data to file
		file.store_float(master_volume)
		file.store_float(music_volume)
		file.store_float(sound_volume)
		file.close()
