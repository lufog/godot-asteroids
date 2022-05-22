extends BaseScreen


signal restart_initiated


func _on_restart_button_pressed() -> void:
	restart_initiated.emit()
