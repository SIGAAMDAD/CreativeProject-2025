class_name MenuSystem extends Control

enum State {
	Title,
	SaveSlots,
	Main,
	CharacterCreation,
}

const HOVERED_SFX = preload( "res://sounds/ui/hover.wav" )
const PRESSED_SFX = preload( "res://sounds/ui/pressed.wav" )

@onready var _title_screen: TitleScreen = $TitleScreen
@onready var _main_menu: MainMenu = $MainMenu
@onready var _character_select_screen: CharacterCreator = $CharacterCreationScreen

@onready var _music_theme: AudioStreamPlayer = $ThemeStream
@onready var _sfx_player: AudioStreamPlayer = $UISfx

var _state: State = State.Title

func _disable_menu( menu: Control ) -> void:
	menu.visible = false
	menu.process_mode = Node.PROCESS_MODE_DISABLED


func _enable_menu( menu: Control ) -> void:
	menu.visible = true
	menu.process_mode = Node.PROCESS_MODE_ALWAYS


func _on_transition_to_main_menu() -> void:
	_disable_menu( _title_screen )
	_enable_menu( _main_menu )
	_disable_menu( _character_select_screen )


func _on_transition_to_title_screen() -> void:
	_enable_menu( _title_screen )
	_disable_menu( _main_menu )
	_disable_menu( _character_select_screen )


func _on_transition_to_character_selection_screen() -> void:
	_disable_menu( _title_screen )
	_disable_menu( _main_menu )
	_enable_menu( _character_select_screen )


func _on_ui_button_pressed() -> void:
	_sfx_player.stream = PRESSED_SFX
	_sfx_player.play()


func _on_ui_button_hovered() -> void:
	_sfx_player.stream = HOVERED_SFX
	_sfx_player.play()


func _hook_button_sfx( node: Node ) -> void:
	for child in node.get_children():
		if child is Button:
			child.pressed.connect( _on_ui_button_pressed )
			child.focus_entered.connect( _on_ui_button_hovered )
			child.mouse_entered.connect( _on_ui_button_hovered )
		
		_hook_button_sfx( child )


func _ready() -> void:
	_title_screen.transition_to_main_menu.connect( _on_transition_to_main_menu )
	_main_menu.transition_to_titlescreen.connect( _on_transition_to_title_screen )
	_main_menu.transition_to_character_select_screen.connect( _on_transition_to_character_selection_screen )
	_character_select_screen.exit.connect( _on_transition_to_main_menu )
	_music_theme.finished.connect( func(): _music_theme.play() )
	_hook_button_sfx( self )
