extends Control


@export var master_volume_slider_nodepach: NodePath
@export var music_volume_slider_nodepach: NodePath
@export var sound_volume_slider_nodepach: NodePath

@onready var master_volume_slider := get_node(master_volume_slider_nodepach) as Slider
@onready var music_volume_slider := get_node(music_volume_slider_nodepach) as Slider
@onready var sound_volume_slider := get_node(sound_volume_slider_nodepach) as Slider


func _ready() -> void:
	master_volume_slider.value = Settings.master_volume
	music_volume_slider.value = Settings.music_volume
	sound_volume_slider.value = Settings.sound_volume


func _on_apply_button_pressed() -> void:
	Settings.master_volume = master_volume_slider.value
	Settings.music_volume = music_volume_slider.value
	Settings.sound_volume = sound_volume_slider.value
	
	Settings.save_to_file()
