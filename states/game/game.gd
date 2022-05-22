extends Node


const MAX_SCORE: int = 999_999_999
const MAX_LEVEL: int = 999

@export var player_lives_initial := 3
@export var player_lives_max := 5
@export var player_scene: PackedScene

@export var asteroids_amount_initial := 2
@export var asteroids_amount_per_level := 1
@export var asteroid_scenes: Array[PackedScene]

var game_over := false
var asteroids_to_spawn := 0

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
		_player_lives = clamp(value, 0, player_lives_max)
		GameEvents.player_lives_changed.emit(_player_lives)

@onready var screens := $Screens as CanvasLayer
@onready var asteroid_container = $AsteroidContainer as Node


func _ready() -> void:
	GameEvents.player_died.connect(_on_player_died)
	GameEvents.score_points_added.connect(func(v: int) -> void: score += v)
	start_game()


func _process(_delta: float) -> void:
	if not game_over and asteroid_container.get_child_count() == 0:
		_next_level()


func _on_player_died() -> void:
	player_lives -= 1
	
	if (player_lives > 0):
		_spawn_player()
	else:
		_game_over()


func _on_restart_initiated() -> void:
	start_game()


func start_game() -> void:
	for asteroid in asteroid_container.get_children():
		asteroid.queue_free()
	
	screens.change_screen(UI.ScreenNames.HUD)
	game_over = false
	asteroids_to_spawn = asteroids_amount_initial
	level = 1
	score = 0
	player_lives = player_lives_initial
	_spawn_player()
	_spawn_asteroids()


func _game_over() -> void:
	screens.change_screen(UI.ScreenNames.GAME_OVER)
	game_over = true


func _next_level() -> void:
	level += 1;
	asteroids_to_spawn += asteroids_amount_per_level
	_spawn_asteroids()


func _spawn_player() -> void:
	var player := player_scene.instantiate() as RigidDynamicBody2D
	add_child.call_deferred(player)
	player.position = Helpers.get_screen_center() + Vector2(300, 0)


func _spawn_asteroids() -> void:
	for i in asteroids_to_spawn:
		var index := randi_range(0, asteroid_scenes.size() - 1)
		var asteroid := asteroid_scenes[index].instantiate() as Asteroid
		asteroid_container.add_child(asteroid)
		
		asteroid.position = Helpers.get_screen_center()
		
		var move_direction := Vector2(randf_range(-1, 1), randf_range(-1, 1))
		var move_speed := randf_range(30, 100)
		asteroid.linear_velocity = move_direction * move_speed
		
		var rotate_direction: float = [-1.0, 1.0][randi_range(0, 1)]
		var rotate_speed := randf_range(0.5, 1.0)
		asteroid.angular_velocity = rotate_direction * rotate_speed
