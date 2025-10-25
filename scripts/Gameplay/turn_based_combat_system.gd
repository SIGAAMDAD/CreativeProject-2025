class_name TurnBasedCombatSystem extends Node

@onready var _ui: TurnBasedUI = $TurnBasedUI
@onready var _sound_channel: AudioStreamPlayer = $CombatEffectChannel

var _current_turn: int = 0
var _turn_order: Array[ CharacterStats ]
var _fighters: Array[ CharacterBody2D ]

signal turn_started( owner: CharacterStats )
signal turn_order_calculated( order: Array[ CharacterStats ] )

func _calc_initiative( stats: CharacterStats ) -> int:
	return DiceGlobal.D20.roll( 1, stats._dexterity._modifier )


func _sort_initiative( a: CharacterStats, b: CharacterStats ) -> bool:
	return true if _calc_initiative( a ) > _calc_initiative( b ) else false


func play_sound( stream: AudioStream ) -> void:
	_sound_channel.stream = stream
	_sound_channel.play()


func _calc_turn_order() -> void:
	for fighter in _fighters:
		_turn_order.push_back( fighter )
	
	_turn_order.sort_custom( _sort_initiative )
	turn_order_calculated.emit( _turn_order )


func _on_attack_selected( attack: int ) -> void:
	
	pass

#
# ===============
# _on_turn_begin
# ===============
#
func _on_turn_begin() -> void:
	pass


#
# ===============
# step
# ===============
#
func step() -> void:
	pass


func _add_team_to_fighters( team: Team ) -> void:
	for member in team._members:
		_fighters.push_back( team )


func _start_fight() -> void:
	pass


#
# ===============
# _init
# ===============
#
func begin_combat( team1: Team, team2: Team ) -> void:
	_fighters.clear()
	_add_team_to_fighters( team1 )
	_add_team_to_fighters( team2 )
	_calc_turn_order()
	_start_fight()
	_ui.show()


func _ready() -> void:
	_ui.attack_selected.connect( _on_attack_selected )
