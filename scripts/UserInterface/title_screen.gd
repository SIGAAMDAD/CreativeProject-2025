class_name TitleScreen extends Control

#
# ===============
# _unhandled_input
# ===============
#
func _unhandled_input( _event: InputEvent ) -> void:
	if Input.is_action_just_released( "ui_cancel" ):
		get_tree().quit()
	else:
		get_tree().change_scene_to_file( "res://scenes/main_menu.tscn" )
