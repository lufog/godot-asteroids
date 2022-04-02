extends Control


var _paused := false
var paused:
	get:
		return _paused
		
	set(value):
		_paused = value
		tree.paused = _paused
		visible = _paused

@onready var tree := get_tree()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		paused = not paused


func _on_resume_pressed() -> void:
	paused = false


func _on_quit_pressed() -> void:
	tree.quit()
