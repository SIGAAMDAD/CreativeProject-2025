class_name MainMenu extends Control

@onready var _options_container: VBoxContainer = $MainContainer/OptionsContainer

signal set_menu_state( state: MenuSystem.State )

#
# ===============
# _on_visibility_changed
# ===============
#
func _on_visibility_changed() -> void:
	if visible:
		var _play_game_button: Button = get_node( "MainContainer/OptionsContainer/PlayGameButton" )
		if SaveManager.has_progress_in_current_slot():
			_play_game_button.text = "CONTINUE GAME"
		else:
			_play_game_button.text = "START GAME"
		
		_play_game_button.grab_focus()


#
# ===============
# _on_play_game_button_pressed
# ===============
#
func _on_play_game_button_pressed() -> void:
	if SaveManager.has_progress_in_current_slot():
		SaveManager.load()
	else:
		set_menu_state.emit( MenuSystem.State.CharacterCreation )


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
# _ready
# ===============
#
func _ready() -> void:
	set_meta( "index", MenuSystem.State.Main )


#
# ===============
# _unhandled_input
# ===============
#
func _unhandled_input( _event: InputEvent ) -> void:
	if Input.is_action_just_released( "ui_cancel" ):
		set_menu_state.emit( MenuSystem.State.SaveSlots )
