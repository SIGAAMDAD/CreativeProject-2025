class_name PauseMenu extends CanvasLayer

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
	get_tree().paused = false
	get_tree().change_scene_to_file( "res://scenes/menu_system.tscn" )


#
# ===============
# _on_visibility_changed
# ===============
#
func _on_visibility_changed() -> void:
	get_tree().paused = visible


#
# ===============
# _unhandled_input
# ===============
#
func _unhandled_input( event: InputEvent ) -> void:
	if Input.is_action_just_released( "ui_cancel" ):
		visible = !visible
