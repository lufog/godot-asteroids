extends CanvasLayer
class_name Screens


enum ScreenNames { TITLE, SETTINGS, ABOUT }


@onready var title_screen := $Title as BaseScreen
@onready var settings_screen := $Settings as BaseScreen
@onready var about_screen := $About as BaseScreen


func _ready() -> void:
	title_screen.change_screen_initiated.connect(self.change_screen)
	settings_screen.change_screen_initiated.connect(self.change_screen)
	about_screen.change_screen_initiated.connect(self.change_screen)


func change_screen(screen_name: ScreenNames) -> void:
	title_screen.visible = false
	settings_screen.visible = false
	about_screen.visible = false
	
	match screen_name:
		ScreenNames.TITLE:
			title_screen.visible = true
			
		ScreenNames.SETTINGS:
			settings_screen.visible = true
			
		ScreenNames.ABOUT:
			about_screen.visible = true
