class_name AttackInfoContainer extends VBoxContainer

const FOCUSED: Color = Color( 1.0, 1.0, 1.0, 1.0 )
const UNFOCUSED: Color = Color( 1.0, 1.0, 1.0, 0.50 )

@onready var _image: TextureButton = $TextureRect
@onready var _indicator: HSeparator = $HSeparator

signal pressed()

func _on_focused() -> void:
	_image.modulate = FOCUSED
	_indicator.show()


func _on_unfocused() -> void:
	_image.modulate = UNFOCUSED
	_indicator.hide()


func _on_pressed() -> void:
	pressed.emit()
