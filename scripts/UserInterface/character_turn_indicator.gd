class_name CharacterTurnIndicator extends HBoxContainer

const MUGSHOT_COLOR_TURN_OWNED: Color = Color( 1.0, 1.0, 1.0, 1.0 )
const MUGSHOT_COLOR_INACTIVE: Color = Color( 1.0, 1.0, 1.0, 0.50 )

@onready var _indicator: VSeparator = $VSeparator
@onready var _mugshot: TextureRect = $TextureRect

func activate() -> void:
	_mugshot.modulate = MUGSHOT_COLOR_TURN_OWNED
	_indicator.show()


func deactivate() -> void:
	_mugshot.modulate = MUGSHOT_COLOR_INACTIVE
	_indicator.hide()


func _ready() -> void:
	_mugshot.modulate = MUGSHOT_COLOR_INACTIVE
