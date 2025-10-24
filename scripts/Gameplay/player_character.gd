class_name PlayerCharacter extends CharacterBody2D

@onready var _team: Team = $Team

var _health: int = 0
var _stats: CharacterStats = null

#
# ===============
# set_preset
# ===============
#
func set_preset( preset: CharacterStats ) -> void:
	_stats = preset


#
# ===============
# save
# ===============
#
func save( file: FileAccess ) -> void:
	file.store_pascal_string( _stats._name )
	file.store_32( _health )
	_stats.save( file )


#
# ===============
# load
# ===============
#
func load( file: FileAccess ) -> void:
	_stats._name = file.get_pascal_string()
	_health = file.get_32()
	_stats.load( file )


#
# ===============
# _init
# ===============
#
func _init() -> void:
	set_preset( CharacterData._player_preset )


#
# ===============
# _process
# ===============
#
func _process( _delta: float ) -> void:
	var _move_direction: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed( "move_down" ):
		_move_direction.y = -1.0
	if Input.is_action_pressed( "move_up" ):
		_move_direction.y = 1.0
	if Input.is_action_pressed( "move_left" ):
		_move_direction.x = -1.0
	if Input.is_action_pressed( "move_right" ):
		_move_direction.x = 1.0
	
	velocity = _move_direction
	move_and_slide()
