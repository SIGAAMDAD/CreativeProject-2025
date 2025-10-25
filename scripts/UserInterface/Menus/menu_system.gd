class_name MenuSystem extends Control

enum State {
	Title,
	SaveSlots,
	Main,
	CharacterCreation,
}

@onready var _title_screen: TitleScreen = $TitleScreen
@onready var _save_slots_menu: SaveSlotsMenu = $SaveSlotsMenu
@onready var _main_menu: MainMenu = $MainMenu
@onready var _character_select_screen: CharacterCreator = $CharacterCreationScreen

@onready var _menus: Array[ Control ] = [
	_title_screen,
	_save_slots_menu,
	_main_menu,
	_character_select_screen,
]

@onready var _music_theme: AudioStreamPlayer = $ThemeStream
@onready var _focused_sfx: AudioStreamPlayer = $UIFocusedSfx
@onready var _pressed_sfx: AudioStreamPlayer = $UIPressedSfx

#
# ===============
# _disable_menu
# ===============
#
func _disable_menu( menu: Control ) -> void:
	menu.visible = false
	menu.process_mode = Node.PROCESS_MODE_DISABLED


#
# ===============
# _enable_menu
# ===============
#
func _enable_menu( menu: Control ) -> void:
	menu.visible = true
	menu.process_mode = Node.PROCESS_MODE_ALWAYS


#
# ===============
# _on_set_menu_state
# ===============
#
func _on_set_menu_state( state: State ) -> void:
	print( "Setting menu state to '" + var_to_str( state ) + "'..." )
	for menu in _menus:
		if menu.get_meta( "index" ) == state:
			_enable_menu( menu )
		else:
			_disable_menu( menu )


#
# ===============
# _on_ui_button_pressed
# ===============
#
func _on_ui_button_pressed() -> void:
	_pressed_sfx.play()


#
# ===============
# _on_ui_button_hovered
# ===============
#
func _on_ui_button_hovered() -> void:
	_focused_sfx.play()


#
# ===============
# _hook_button_sfx
# ===============
#
func _hook_button_sfx( node: Node ) -> void:
	for child in node.get_children():
		if child is Button:
			if !child.pressed.is_connected( _on_ui_button_pressed ):
				child.pressed.connect( _on_ui_button_pressed )
			if !child.focus_entered.is_connected( _on_ui_button_hovered ):
				child.focus_entered.connect( _on_ui_button_hovered )
			if !child.mouse_entered.is_connected( _on_ui_button_hovered ):
				child.mouse_entered.connect( _on_ui_button_hovered )
		
		_hook_button_sfx( child )


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	for menu in _menus:
		menu.set_menu_state.connect( _on_set_menu_state )
	
	_music_theme.finished.connect( func(): _music_theme.play() )
	_hook_button_sfx( self )
