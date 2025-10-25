class_name SaveSlotsMenu extends Control

signal set_menu_state( state: MenuSystem.State )

#TODO: nameable slots

#
# ===============
# _set_save_slot
# ===============
#
func _set_save_slot( slot: int ) -> void:
	SaveManager.set_slot( slot, "Unnamed" )
	set_menu_state.emit( MenuSystem.State.Main )


#
# ===============
# _on_slot_focused
# ===============
#
func _on_slot_focused( slot: int ) -> void:
	SaveManager.set_slot( slot, "Unnamed" )


#
# ===============
# _init_save_slots
# ===============
#
func _init_save_slots() -> void:
	for slot in SaveSlotManager.MAX_SAVE_SLOTS:
		var _button: SaveSlotButton = get_node( "MainContainer/SaveSlotsSelectContainer" ).get_child( slot )
		if !_button.selected.is_connected( _set_save_slot ):
			_button.selected.connect( _set_save_slot )
		if !_button.highlighted.is_connected( _on_slot_focused ):
			_button.highlighted.connect( _on_slot_focused )


#
# ===============
# _update_save_slots
# ===============
#
func _update_save_slots() -> void:
	_init_save_slots()


#
# ===============
# _on_visibility_changed
# ===============
#
func _on_visibility_changed() -> void:
	if visible:
		_update_save_slots()
		
		get_node( "MainContainer/SaveSlotsSelectContainer" ).get_child( 0 ).grab_focus()


func _ready() -> void:
	set_meta( "index", MenuSystem.State.SaveSlots )


#
# ===============
# _unhandled_input
# ===============
#
func _unhandled_input( _event: InputEvent ) -> void:
	if Input.is_action_just_pressed( "ui_cancel" ):
		set_menu_state.emit( MenuSystem.State.Title )
