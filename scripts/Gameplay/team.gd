class_name Team extends Node

var _members: Array[ CharacterBody2D ]

signal turn_begin()
signal turn_end()

#
# ===============
# save
# ===============
#
func save( file: FileAccess ) -> void:
	file.store_32( _members.size() )
	for member in _members:
		file.store_pascal_string( member.get_path() )


#
# ===============
# load
# ===============
#
func load( file: FileAccess ) -> void:
	var _count: int = file.get_32()
	_members.clear()
	for index in _count:
		_members.push_back( get_node( file.get_pascal_string() ) )


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	pass
