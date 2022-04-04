@tool

extends Button


@export_file("*.tscn") var scene_path: String

@onready var tree := get_tree()


func _on_pressed() -> void:
	if not scene_path.is_empty():
		tree.change_scene(scene_path)


# Editor specific
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array[String] = []
	
	if scene_path.is_empty():
		warnings.append("This button has no assigned scene, so it can't change scene when pressed. \
				Consider specifying а path to а scene you want to transition to.")
	
	return PackedStringArray(warnings)
