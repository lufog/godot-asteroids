extends BaseScreen


@onready var lives_value := $"%Lives/Value" as Label
@onready var score_value := $"%Score/Value" as Label
@onready var level_container := $"%Level" as Control
@onready var level_value := $"%Level/Value" as Label
@onready var level_hide_timer := $LevelHide as Timer


func _ready() -> void:
	GameEvents.score_changed.connect(_on_score_changed)
	GameEvents.level_changed.connect(_on_level_changed)
	GameEvents.player_lives_changed.connect(_on_player_lives_changed)


func _on_score_changed(value: int) -> void:
	score_value.text = str(value)


func _on_level_changed(value: int) -> void:
	level_value.text = str(value)
	level_container.show()
	level_hide_timer.start()


func _on_level_hide_timer_timeout() -> void:
	level_container.hide()


func _on_player_lives_changed(value: int) -> void:
	lives_value.text = str(value)
