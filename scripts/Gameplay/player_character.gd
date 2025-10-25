class_name PlayerCharacter extends CharacterBody2D

@onready var _team: Team = $Team
@onready var _animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var _audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer2D

var _move_sounds: Array[ AudioStream ] = [
	load( "res://sounds/move/move_gravel_0.wav" ),
	load( "res://sounds/move/move_gravel_1.wav" ),
	load( "res://sounds/move/move_gravel_2.wav" ),
	load( "res://sounds/move/move_gravel_3.wav" )
]

var _health: int = 0
var _stats: CharacterStats = null
var _preset: CharacterPreset = null

#
# ===============
# set_preset
# ===============
#
func set_preset( preset: CharacterPreset ) -> void:
	_preset = preset
	_stats = _preset._stats


#
# ===============
# save
# ===============
#
func save( file: FileAccess ) -> void:
	file.store_pascal_string( _stats._name )
	file.store_32( _health )
	_stats.save( file )
	_team.save( file )


#
# ===============
# load
# ===============
#
func load( file: FileAccess ) -> void:
	_stats._name = file.get_pascal_string()
	_health = file.get_32()
	_stats.load( file )
	_team.load( file )


#
# ===============
# play_sound
# ===============
#
func play_sound( stream: AudioStream ) -> void:
	_audio_stream.stream = stream
	_audio_stream.play()


#
# ===============
# _on_animated_sprite_2d_animation_looped
# ===============
#
func _on_animated_sprite_2d_animation_looped() -> void:
	if _animations.animation != "idle":
		play_sound( _move_sounds[ randi_range( 0, 3 ) ] )


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	set_preset( CharacterData._player_preset )
	
	SaveManager.save_game.connect( save )
	
	var _sprites: AnimatedSprite2D = get_node( "AnimatedSprite2D" )
	_sprites.sprite_frames = _preset._animations


#
# ===============
# _physics_process
# ===============
#
func _physics_process( delta: float ) -> void:
	var _speed: float = ( 140.0 + ( _stats._dexterity._modifier * 0.1 ) ) * delta
	var _moving: bool = false
	var _animation: StringName = "idle"
	
	if Input.is_action_pressed( "move_up" ):
		position.y -= _speed
		_moving = true
		_animation = "move_vertical"
	if Input.is_action_pressed( "move_down" ):
		position.y += _speed
		_moving = true
		_animation = "move_vertical"
	if Input.is_action_pressed( "move_left" ):
		position.x -= _speed
		_moving = true
		_animation = "move_horizontal"
		_animations.flip_h = true
	if Input.is_action_pressed( "move_right" ):
		position.x += _speed
		_moving = true
		_animation = "move_horizontal"
		_animations.flip_h = false
	
	if _moving:
		_animations.play( _animation )
	else:
		_animations.play( "idle" )
