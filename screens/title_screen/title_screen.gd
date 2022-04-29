extends BaseScreen


@onready var tree := get_tree()


func _on_settings_button_pressed() -> void:
	change_screen_initiated.emit(Screens.ScreenNames.SETTINGS)


func _on_about_button_pressed() -> void:
	change_screen_initiated.emit(Screens.ScreenNames.ABOUT)


func _on_quit_button_pressed() -> void:
	tree.quit()
