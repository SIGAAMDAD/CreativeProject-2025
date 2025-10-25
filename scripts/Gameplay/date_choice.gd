class_name DateChoice extends Node2D

@export var _dialogue: DialogueResource
@export var _stats: CharacterStats

var _knows_player: bool = false
var _favor: int = 0

func meet_player() -> void:
	_knows_player = true
	_favor = 0


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
