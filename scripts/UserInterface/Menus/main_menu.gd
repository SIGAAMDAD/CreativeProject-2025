class_name MainMenu extends Control

@onready var _title: Label = $MainContainer/MenuTitle
@onready var _save_slots_container: VBoxContainer = $MainContainer/SaveSlotsSelectContainer
@onready var _options_container: VBoxContainer = $MainContainer/OptionsContainer
@onready var _audio_player: AudioStreamPlayer = $AudioStreamPlayer

var _current_slot: int = 0

signal transition_to_titlescreen()
signal transition_to_character_select_screen()

#
# ===============
# _set_save_slot
# ===============
#
func _set_save_slot( slot: int ) -> void:
	SaveManager.set_slot( slot )
	_save_slots_container.hide()
	
	if SaveManager.has_progress_in_current_slot():
		var _play_game_button: Button = get_node( "MainContainer/OptionsContainer/PlayGameButton" )
		_play_game_button.text = "CONTINUE GAME"
	
	_options_container.show()
	_title.text = "MAIN MENU"


#
# ===============
# _on_play_game_button_pressed
# ===============
#
func _on_play_game_button_pressed() -> void:
	if SaveManager.has_progress_in_current_slot():
		SaveManager.load()
	else:
		transition_to_character_select_screen.emit()


#
# ===============
# _on_settings_menu_button_pressed
# ===============
#
func _on_settings_menu_button_pressed() -> void:
	pass # Replace with function body.


#
# ===============
# _on_quit_game_button_pressed
# ===============
#
func _on_quit_game_button_pressed() -> void:
	get_tree().quit()


#
# ===============
# _on_slot_focused
# ===============
#
func _on_slot_focused( slot: int ) -> void:
	_current_slot = slot


#
# ===============
# _init_slots
# ===============
#
func _init_slots() -> void:
	for slot in SaveSlotManager.MAX_SAVE_SLOTS:
		var _button: SaveSlotButton = get_node( "MainContainer/SaveSlotsSelectContainer" ).get_child( slot )
		_button.connect( "selected", _set_save_slot )
		_button.connect( "highlighted", _on_slot_focused )


func update_save_slots() -> void:
	for slot in SaveSlotManager.MAX_SAVE_SLOTS:
		get_node( "MainContainer/SaveSlotsSelectContainer" ).get_child( slot ).update()


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	_init_slots()
	update_save_slots()
	
	get_node( "MainContainer/SaveSlotsSelectContainer" ).get_child( 0 ).grab_focus()


#
# ===============
# _unhandled_input
# ===============
#
func _unhandled_input( event: InputEvent ) -> void:
	if Input.is_action_just_released( "ui_cancel" ):
		if _save_slots_container.visible:
			transition_to_titlescreen.emit()
		else:
			update_save_slots()
			_options_container.hide()
			_save_slots_container.show()
