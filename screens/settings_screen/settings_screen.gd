extends Control


@export var music_volume_slider_nodepach: NodePath
@export var sound_volume_slider_nodepach: NodePath

@onready var music_volume_slider := get_node(music_volume_slider_nodepach) as Slider
@onready var sound_volume_slider := get_node(sound_volume_slider_nodepach) as Slider


func _ready() -> void:
	music_volume_slider.value = Settings.music_volume
	sound_volume_slider.value = Settings.sound_volume


func _on_apply_button_pressed() -> void:
	Settings.music_volume = music_volume_slider.value
	Settings.sound_volume = sound_volume_slider.value
	
	Settings.save_to_file()
