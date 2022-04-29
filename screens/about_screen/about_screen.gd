extends BaseScreen


func _on_about_text_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)


func _on_back_button_pressed() -> void:
	change_screen_initiated.emit(Screens.ScreenNames.TITLE)
