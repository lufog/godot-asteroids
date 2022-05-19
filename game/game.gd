extends Node


@export var max_lives: int = 3
@export var player_scene: PackedScene

const MAX_SCORE: int = 999_999_999
const MAX_LEVEL: int = 999

var _score: int
var score:
	get:
		return _score
	set(value):
		_score = clamp(value, 0, MAX_SCORE)
		GameEvents.score_changed.emit(_score)

var _level: int
var level:
	get:
		return _level
	set(value):
		_level = clamp(value, 0, MAX_LEVEL)
		GameEvents.level_changed.emit(_level)

var _player_lives: int
var player_lives:
	get:
		return _player_lives
	set(value):
		_player_lives = clamp(value, 0, max_lives)
		GameEvents.player_lives_changed.emit(_player_lives)

@onready var asteroid_spawner = $AsteroidSpawner as AsteroidSpawner


func _ready() -> void:
	GameEvents.score_points_added.connect(
		func(v: int) -> void: score += v
	)
	
	new_game()


func new_game() -> void:
	spawn_player()
	asteroid_spawner.spawn_asteroids()
	level = 1


func spawn_player() -> void:
	var player := player_scene.instantiate() as RigidDynamicBody2D
	add_child(player)
	player.position = Helpers.get_screen_center()


func next_level() -> void:
	level += 1
