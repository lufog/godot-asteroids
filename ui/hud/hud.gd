extends Control

@export var lives_nodepath: NodePath

@onready var lives := get_node(lives_nodepath) as TextureRect


func _ready() -> void:
	GameEvents.player_lives_changed.connect(self._on_player_lives_changed)


func _on_player_lives_changed(count: int) -> void:
	lives.size.x = count * lives.texture.get_size().x
