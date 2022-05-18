extends CanvasLayer


@onready var hud_screen := $Hud as BaseScreen
@onready var pause_screen := $Pause as BaseScreen
@onready var tree := get_tree()


func _ready() -> void:
	hud_screen.change_screen_initiated.connect(change_screen)
	pause_screen.change_screen_initiated.connect(change_screen)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if not tree.paused:
			tree.paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			change_screen("PauseScreen")
			
		else:
			tree.paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			change_screen("HudScreen")


func _exit_tree() -> void:
	tree.set_deferred("paused", false)


func change_screen(screen_name: String) -> void:
	hud_screen.visible = false
	pause_screen.visible = false
	
	match screen_name:
		"HudScreen":
			hud_screen.visible = true
			
		"PauseScreen":
			pause_screen.visible = true
