class_name CharacterChoiceButton extends VBoxContainer

var _character_option: CharacterPreset

signal pressed()

func _ready() -> void:
	var _character_choice_button: TextureButton = get_node( "Mugshot" )
	_character_choice_button.texture_normal = _character_option._stats._mugshot
	_character_choice_button.connect( "pressed", func(): pressed.emit() )
	
	var _name_label: Label = get_node( "Name" )
	_name_label.text = _character_option._stats._name
