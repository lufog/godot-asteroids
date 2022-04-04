extends Button


@export_file("*.tscn") var scene_path: String

@onready var tree := get_tree()


func _on_pressed() -> void:
	tree.change_scene(scene_path)
