class_name PauseMenu extends CanvasLayer

var _master_bus_index: int = 0

#
# ===============
# _on_resume_button_pressed
# ===============
#
func _on_resume_button_pressed() -> void:
	hide()


#
# ===============
# _on_quit_game_button_pressed
# ===============
#
func _on_quit_game_button_pressed() -> void:
	AudioServer.set_bus_effect_enabled( _master_bus_index, 0, false )
	get_tree().paused = false
	get_tree().change_scene_to_file( "res://scenes/Menus/menu_system.tscn" )


#
# ===============
# _on_visibility_changed
# ===============
#
func _on_visibility_changed() -> void:
	AudioServer.set_bus_effect_enabled( _master_bus_index, 0, visible )
	get_tree().paused = visible


func _ready() -> void:
	_master_bus_index = AudioServer.get_bus_index( "Master" )


#
# ===============
# _unhandled_input
# ===============
#
func _unhandled_input( _event: InputEvent ) -> void:
	if Input.is_action_just_released( "ui_cancel" ):
		visible = !visible
