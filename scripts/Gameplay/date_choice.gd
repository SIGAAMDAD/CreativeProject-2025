class_name DateChoice extends Node2D

@export var _dialogue: DialogueResource
@export var _stats: CharacterStats

var _knows_player: bool = false
var _favor: int = 0

signal interaction_begin()
signal interaction_end()

#
# ===============
# _on_interact_area_area_shape_entered
# ===============
#
func _on_interact_area_area_shape_entered( area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int ) -> void:
	if _knows_player:
		DialogueManager.show_dialogue_balloon( _dialogue, "meet" )


#
# ===============
# load
# ===============
#
func load( file: FileAccess ) -> void:
	_knows_player = file.get_8()
	_favor = file.get_32()
	_stats.load( file )


#
# ===============
# save
# ===============
#
func save( file: FileAccess ) -> void:
	file.store_8( _knows_player )
	file.store_32( _favor )
	_stats.save( file )


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	pass
