extends BaseScreen


func _on_settings_button_pressed() -> void:
	change_screen_initiated.emit("SettingsScreen")


func _on_about_button_pressed() -> void:
	change_screen_initiated.emit("AboutScreen")
