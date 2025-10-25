class_name InteractionArea extends Area2D

enum AreaType {
	Fight,
	NPC,
	Hookup,
	Region,
	LoreDump,
}

@export var _type: AreaType = AreaType.Fight

func _on_body_shape_entered( _body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int ) -> void:
	if body is PlayerCharacter:
		CharacterData.start_interaction( self )

#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	body_shape_entered.connect( _on_body_shape_entered )
