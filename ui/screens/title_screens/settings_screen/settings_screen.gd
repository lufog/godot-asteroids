extends BaseScreen


@onready var master_volume_slider := $"%MasterSlider" as Slider
@onready var music_volume_slider := $"%MusicSlider" as Slider
@onready var sound_volume_slider := $"%SoundSlider" as Slider


func _ready() -> void:
	master_volume_slider.value = Settings.master_volume
	music_volume_slider.value = Settings.music_volume
	sound_volume_slider.value = Settings.sound_volume


func _on_back_button_pressed() -> void:
	change_screen_initiated.emit(UI.ScreenNames.TITLE)


func _on_apply_button_pressed() -> void:
	Settings.master_volume = master_volume_slider.value
	Settings.music_volume = music_volume_slider.value
	Settings.sound_volume = sound_volume_slider.value
	
	Settings.save_to_file()
