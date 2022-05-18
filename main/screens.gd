extends CanvasLayer


@onready var title_screen := $Title as BaseScreen
@onready var settings_screen := $Settings as BaseScreen
@onready var about_screen := $About as BaseScreen


func _ready() -> void:
	title_screen.change_screen_initiated.connect(change_screen)
	settings_screen.change_screen_initiated.connect(change_screen)
	about_screen.change_screen_initiated.connect(change_screen)


func change_screen(screen_name: String) -> void:
	title_screen.visible = false
	settings_screen.visible = false
	about_screen.visible = false
	
	match screen_name:
		"TitleScreen":
			title_screen.visible = true
			
		"SettingsScreen":
			settings_screen.visible = true
			
		"AboutScreen":
			about_screen.visible = true
