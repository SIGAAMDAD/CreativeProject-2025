class_name CharacterStats extends Resource

@export var _strength: int = 0
@export var _dexterity: int = 0
@export var _intelligence: int = 0
@export var _wisdom: int = 0
@export var _charisma: int = 0

@export var _mugshot: Texture2D

func save( file: FileAccess ) -> void:
	_strength = file.get_32()
	_dexterity = file.get_32()
	_intelligence = file.get_32()
	_wisdom = file.get_32()
	_charisma = file.get_32()

func load( file: FileAccess ) -> void:
	file.store_32( _strength )
	file.store_32( _dexterity )
	file.store_32( _intelligence )
	file.store_32( _wisdom )
	file.store_32( _charisma )
