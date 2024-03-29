extends CanvasLayer


@onready var hud_screen := $Hud as BaseScreen
@onready var pause_screen := $Pause as BaseScreen
@onready var game_over_screen := $GameOver as BaseScreen
@onready var tree := get_tree()


func _ready() -> void:
	hud_screen.change_screen_initiated.connect(change_screen)
	pause_screen.change_screen_initiated.connect(change_screen)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if not tree.paused:
			change_screen(UI.ScreenNames.PAUSE)
		else:
			change_screen(UI.ScreenNames.HUD)


func _exit_tree() -> void:
	tree.set_deferred("paused", false)


func change_screen(screen_name: UI.ScreenNames) -> void:
	hud_screen.hide()
	pause_screen.hide()
	game_over_screen.hide()
	
	tree.paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	match screen_name:
		UI.ScreenNames.HUD:
			hud_screen.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		
		UI.ScreenNames.PAUSE:
			tree.paused = true
			pause_screen.show()
		
		UI.ScreenNames.GAME_OVER:
			game_over_screen.show()
