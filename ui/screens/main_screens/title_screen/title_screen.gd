extends BaseScreen


func _on_settings_button_pressed() -> void:
	change_screen_initiated.emit(UI.ScreenNames.SETTINGS)


func _on_about_button_pressed() -> void:
	change_screen_initiated.emit(UI.ScreenNames.ABOUT)
