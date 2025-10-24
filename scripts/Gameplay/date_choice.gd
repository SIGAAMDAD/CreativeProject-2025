class_name DateChoice extends Node2D

@export var _dialogue: DialogueResource
@export var _stats: CharacterStats

var _knows_player: bool = false

func _on_interact_area_area_shape_entered( area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int ) -> void:
	if _knows_player:
		DialogueManager.show_dialogue_balloon( _dialogue, "meet" )

func load( file: FileAccess ) -> void:
	_knows_player = file.get_8()
	_stats.load( file )

func save( file: FileAccess ) -> void:
	file.store_8( _knows_player )
	_stats.save( file )
