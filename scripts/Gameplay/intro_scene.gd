class_name WorldScene extends SceneBase

@onready var _player: PlayerCharacter = $PlayerCharacter
@onready var _theme_player0: AudioStreamPlayer = $ThemePlayer0
@onready var _theme_player1: AudioStreamPlayer = $ThemePlayer1

var _current_theme: AudioStream
var _current_player: int = 0

var _theme_players: Array[ AudioStreamPlayer ] = [
	$ThemePlayer0,
	$ThemePlayer1
]

func set_music_theme( stream: AudioStream ) -> void:
	if _current_theme != null:
		_theme_players[ _current_player ^ 1 ].stream = stream
		_theme_players[ _current_player ^ 1 ].volume_linear = 0.0
		
		var _tween: Tween = create_tween()
		_tween.tween_property( _theme_players[ _current_player ], "volume_linear", 0.0, 1.5 )
		_tween.parallel().tween_property( _theme_players[ _current_player ^ 1 ], "volume_linear", 1.0, 1.5 )
		
		_current_player ^= _current_player
	else:
		_theme_player0.stream = stream
		_theme_player0.play()

#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	init_base()
	
	_theme_player0.finished.connect( func(): _theme_player0.play() )
	_theme_player1.finished.connect( func(): _theme_player1.play() )
	
	SaveManager.initialize_game()
	SaveManager.save()
