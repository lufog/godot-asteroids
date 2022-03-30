extends Control


@export var lives_nodepath: NodePath
@export var score_value_nodepath: NodePath

@onready var lives := get_node(lives_nodepath) as TextureRect
@onready var score_value := get_node(score_value_nodepath) as Label


func _ready() -> void:
	GameEvents.score_changed.connect(self._on_score_changed)
	GameEvents.player_lives_changed.connect(self._on_player_lives_changed)


func _on_score_changed(value: int) -> void:
	score_value.text = str(value)


func _on_player_lives_changed(count: int) -> void:
	lives.size.x = count * lives.texture.get_size().x
