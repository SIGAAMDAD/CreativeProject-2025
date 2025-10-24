class_name CharacterManager extends Node

var _player_character: PlayerCharacter
var _date_choices: Array[ DateChoice ]
var _player_team: Team
var _enemy_team: Team

func set_player_preset( preset: CharacterStats ) -> void:
	_player_character.set_preset( preset )


#
# ===============
# _load_date_choices
# ===============
#
func _load_date_choices() -> void:
	pass


#
# ===============
# _ready
# ===============
#
func _ready() -> void:

	pass