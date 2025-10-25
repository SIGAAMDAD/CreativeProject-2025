class_name PlayerCharacter extends CharacterBody2D

@onready var _team: Team = $Team

var _health: int = 0
var _stats: CharacterPreset = null

#
# ===============
# set_preset
# ===============
#
func set_preset( preset: CharacterPreset ) -> void:
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
# _ready
# ===============
#
func _ready() -> void:
	set_preset( CharacterData._player_preset )
	
	SaveManager.save_game.connect( save )
	
	var _sprites: AnimatedSprite2D = get_node( "AnimatedSprite2D" )
	_sprites.sprite_frames = _stats._animations


#
# ===============
# _physics_process
# ===============
#
func _physics_process( delta: float ) -> void:
	var _speed: float = ( 140.0 + ( _stats._stats._dexterity._modifier * 0.1 ) ) * delta
	
	if Input.is_action_pressed( "move_up" ):
		position.y -= _speed
	if Input.is_action_pressed( "move_down" ):
		position.y += _speed
	if Input.is_action_pressed( "move_left" ):
		position.x -= _speed
	if Input.is_action_pressed( "move_right" ):
		position.x += _speed
