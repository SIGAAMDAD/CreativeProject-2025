class_name MusicTheme extends AudioStreamPlayer

const MENU_THEME = preload( "res://sounds/music/titlescreen.wav" )

func play_menu_theme() -> void:
	finished.connect( func(): play() )
	stream = MENU_THEME
	play()
