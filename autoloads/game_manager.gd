extends Node


const MAX_SCORE: int = 9_999_999_999

var _score: int
var score:
	get:
		return _score
	set(value):
		_score = clamp(value, 0, MAX_SCORE)
		GameEvents.score_changed.emit(_score)

var max_lives: int = 3

var _player_lives
var player_lives:
	get:
		return _player_lives
	set(value):
		_player_lives = clamp(value, 0, max_lives)
		GameEvents.player_lives_changed.emit(_player_lives)
