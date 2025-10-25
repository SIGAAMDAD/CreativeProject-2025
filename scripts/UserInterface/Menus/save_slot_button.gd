class_name SaveSlotButton extends HBoxContainer

@export var _animate_scale: bool = true
@export var _animate_position: bool = false
@export var _transition_type: Tween.TransitionType

@export_group( "Scale Properties", "scale_" )
@export var _scale_intensity: float = 1.1

@export_group( "Position Properties", "position_" )
@export var _position_value: Vector2 = Vector2( 0, -4 )
@export var _slot_index: int = 0

@export_range( 0, 10, 0.001, "or_greater" ) var _duration = 0.1

@onready var _select_button: Button = $SelectButton
@onready var _delete_button: Button = $DeleteButton
#@onready var _name_edit: TextEdit = $NameEdit

var _tween: Tween
var _btn_start_pos

var _is_btn_hovered: bool = false

signal selected( slot: int )
signal highlighted( slot: int )

#func get_slot_name() -> String:
#	return _name_edit.text


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


func _set_button_state():
	_is_btn_hovered = get_viewport().gui_get_focus_owner() == _select_button


func _hover_scale_animation():
	if _animate_scale:
		if _is_btn_hovered:
			_tweening( self, "scale", Vector2( _scale_intensity, _scale_intensity ), _duration )
		else:
			_tweening( self, "scale", Vector2.ONE, _duration )


func _hover_position_animation():
	if _animate_position:
		if _is_btn_hovered:
			_tweening( self, "position", _btn_start_pos + Vector2( _position_value.x, _position_value.y ), _duration )
		else:
			_tweening( self, "position", _btn_start_pos, _duration )


func _tweening( object: Object, property: NodePath, final_value: Variant, duration: float ):
	_tween = create_tween().set_parallel( true ).set_trans( _transition_type )
	_tween.tween_property( object, property, final_value, duration )
	await _tween.finished
	_tween.kill()


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
	
	pivot_offset = size / 2
	_btn_start_pos = position 


func _process( _delta: float ) -> void:
	_set_button_state()
	_hover_scale_animation()
	_hover_position_animation()
