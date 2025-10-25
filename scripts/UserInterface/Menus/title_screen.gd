class_name TitleScreen extends Control

signal transition_to_main_menu()

#
# ===============
# _unhandled_input
# ===============
#
func _unhandled_input( _event: InputEvent ) -> void:
	if Input.is_action_just_pressed( "ui_cancel" ):
		get_tree().quit()
	else:
		transition_to_main_menu.emit()
