class_name Region extends Node2D

@export var _theme: AudioStream
@export var _name: String

@onready var _interaction_area: InteractionArea = $InteractionArea

func _on_interaction_area_body_shape_entered( _body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int ) -> void:
	get_parent().set_music_theme( _theme )


func _ready() -> void:
	_interaction_area.body_shape_entered.connect( _on_interaction_area_body_shape_entered )
