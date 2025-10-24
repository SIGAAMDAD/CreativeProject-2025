class_name CharacterManager extends Node

var _player_character: PlayerCharacter
var _date_choices: Array[ DateChoice ]
var _player_team: Team
var _enemy_team: Team

var _player_preset: CharacterStats

signal interaction_begin()
signal interaction_end()


#
# ===============
# set_player_preset
# ===============
#
func set_player_preset( preset: CharacterStats ) -> void:
	_player_preset = preset


#
# ===============
# _load_player
# ===============
#
func _load_player() -> void:
	_player_character = get_node( "/root/ActiveScene/PlayerCharacter" )
	_player_team = _player_character.get_node( "Team" )


#
# ===============
# _load_date_choices
# ===============
#
func _load_date_choices() -> void:
	var _nodes: Array[ Node ] = get_tree().get_nodes_in_group( "DateChoices" )
	for node in _nodes:
		_date_choices.push_back( _nodes )
		node.connect( "interaction_begin", func(): interaction_begin.emit() )
		node.connect( "interaction_end", func(): interaction_end.emit() )


#
# ===============
# _load_teams
# ===============
#
func _load_teams() -> void:
	pass


#
# ===============
# _on_load_character_data
# ===============
#
func _on_load_character_data() -> void:
	_load_player.call_deferred()
	_load_date_choices.call_deferred()
	_load_teams.call_deferred()


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	SaveManager.start_game.connect( _on_load_character_data )
