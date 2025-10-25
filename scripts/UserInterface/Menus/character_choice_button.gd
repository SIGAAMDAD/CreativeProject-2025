class_name CharacterChoiceButton extends VBoxContainer

@onready var _character_choice_button: TextureButton = $Mugshot
@onready var _selected_indicator: HSeparator = $Selected

var _character_option: CharacterPreset

signal pressed()
signal focused()
signal unfocused()

func _on_pressed() -> void:
	_selected_indicator.show()
	pressed.emit()


func _on_focused() -> void:
	_selected_indicator.show()
	focused.emit()


func _on_unfocused() -> void:
	_selected_indicator.hide()
	unfocused.emit()


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	name = "CharacterChoice" + _character_option._stats._name
	
	_character_choice_button.texture_normal = _character_option._stats._mugshot
	_character_choice_button.pressed.connect( func(): _on_pressed() )
	_character_choice_button.focus_entered.connect( _on_focused )
#	_character_choice_button.mouse_entered.connect( _on_focused )
	_character_choice_button.focus_exited.connect( _on_unfocused )
#	_character_choice_button.mouse_exited.connect( _on_unfocused )
	
	var _name_label: Label = get_node( "Name" )
	_name_label.text = _character_option._stats._name
