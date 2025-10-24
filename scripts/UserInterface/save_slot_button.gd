class_name SaveSlotButton extends HBoxContainer

signal selected( slot: int )
signal highlighted( slot: int )

@export var _slot_index: int = 0

@onready var _select_button: Button = $SelectButton

#
# ===============
# _on_select_button_pressed
# ===============
#
func _on_select_button_pressed() -> void:
	selected.emit( _slot_index )


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
# _ready
# ===============
#
func _ready() -> void:
	_select_button.connect( "pressed", _on_select_button_pressed )
	
	var _info: SaveSlotManager.SlotInfo = SaveManager.get_progress( _slot_index )
	
	var _text: String = "DATA " + var_to_str( _slot_index ) + " "
	if _info != null:
		_text += _date_to_string( _info )
	else:
		_text += "[EMPTY]"
	
	_select_button.text = _text
	
	connect( "focus_entered", _on_focus_entered )
