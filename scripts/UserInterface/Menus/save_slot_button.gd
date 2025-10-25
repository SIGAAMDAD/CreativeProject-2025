class_name SaveSlotButton extends HBoxContainer

signal selected( slot: int )
signal highlighted( slot: int )

@export var _slot_index: int = 0

@onready var _select_button: Button = $SelectButton
@onready var _delete_button: Button = $DeleteButton

#
# ===============
# _on_select_button_pressed
# ===============
#
func _on_select_button_pressed() -> void:
	selected.emit( _slot_index )


#
# ===============
# _on_delete_button_pressed
# ===============
#
func _on_delete_button_pressed() -> void:
	SaveManager.delete_slot( _slot_index )
	update()


#
# ===============
# _date_to_string
# ===============
#
func _date_to_string( info: SaveSlotManager.SlotInfo ) -> String:
	return var_to_str( info._time_accessed_year ) + ", " + var_to_str( info._time_accessed_day ) + " " + var_to_str( info._time_accessed_month )


#
# ===============
# _on_focus_entered
# ===============
#
func _on_focus_entered() -> void:
	_select_button.grab_focus()
	highlighted.emit( _slot_index )


#
# ===============
# update
# ===============
#
func update() -> void:
	var _info: SaveSlotManager.SlotInfo = SaveManager.get_progress( _slot_index )
	var _text: String = "DATA " + var_to_str( _slot_index ) + " "
	if _info != null:
		_text += _date_to_string( _info )
		_delete_button.text = "ERASE"
	else:
		_delete_button.text = "[EMPTY]"
	
	_select_button.text = _text


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	_delete_button.pressed.connect( _on_delete_button_pressed )
	_select_button.pressed.connect( _on_select_button_pressed )
	update()
	focus_entered.connect( _on_focus_entered )
