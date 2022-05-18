extends BaseScreen


func _on_resume_button_pressed() -> void:
	change_screen_initiated.emit(UI.ScreenNames.HUD)
