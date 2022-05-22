extends CanvasLayer


@onready var title_screen := $Title as BaseScreen
@onready var settings_screen := $Settings as BaseScreen
@onready var about_screen := $About as BaseScreen


func _ready() -> void:
	title_screen.change_screen_initiated.connect(change_screen)
	settings_screen.change_screen_initiated.connect(change_screen)
	about_screen.change_screen_initiated.connect(change_screen)


func change_screen(screen_name: UI.ScreenNames) -> void:
	title_screen.hide()
	settings_screen.hide()
	about_screen.hide()
	
	match screen_name:
		UI.ScreenNames.TITLE:
			title_screen.show()
			
		UI.ScreenNames.SETTINGS:
			settings_screen.show()
			
		UI.ScreenNames.ABOUT:
			about_screen.show()
