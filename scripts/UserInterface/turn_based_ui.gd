class_name TurnBasedUI extends CanvasLayer

const MUGSHOT_TURN_SCENE: PackedScene = preload( "res://scenes/character_turn_indicator.tscn" )
const ATTACK_INFO_SCENE: PackedScene = preload( "res://scenes/attack_info_container.tscn" )

@export var _turn_transition_sfx: AudioStream
@export var _turn_system: TurnBasedCombatSystem

@onready var _character_list: VBoxContainer = $CharacterList
@onready var _character_details: MarginContainer = $CharacterDetails
@onready var _attack_container: HBoxContainer = $AttackContainer

@onready var _team1_position0: Node2D = $Team1Positions/Position0
@onready var _team1_position1: Node2D = $Team1Positions/Position1

@onready var _team2_position0: Node2D = $Team2Positions/Position0
@onready var _team2_position1: Node2D = $Team2Positions/Position0

var _mugshot_lookup: Dictionary[ CharacterStats, CharacterTurnIndicator ]
var _current_owner: CharacterTurnIndicator

signal attack_selected( attack: int )

func _populate_attack_container( attack_list: Array[ AttackData ] ) -> void:
	for child in _attack_container.get_children():
		child.remove_child( child )
	
	var _index: int = 0
	for attack in attack_list:
		var _attack_info: AttackInfoContainer = ATTACK_INFO_SCENE.instantiate()
		_attack_info._image.texture = attack._image
		_attack_info.pressed.connect( func(): attack_selected.emit( _index ) )
		_attack_container.add_child( _attack_info )
		_index += 1


func _add_mugshot_to_character_list( stat: CharacterStats ) -> void:
	var _mugshot: CharacterTurnIndicator = MUGSHOT_TURN_SCENE.instantiate()
	_mugshot.texture = stat._mugshot
	_character_list.add_child( _mugshot )
	_mugshot_lookup[ stat ] = _mugshot


func _populate_character_list( order: Array[ CharacterStats ] ) -> void:
	_mugshot_lookup.clear()
	for member in order:
		_add_mugshot_to_character_list( member )


func _on_step_turn( owner: CharacterStats ) -> void:
	if _current_owner != null:
		_current_owner.deactivate()
	
	_current_owner = _mugshot_lookup[ owner ]
	_current_owner.activate()
	
	_turn_system.play_sound( _turn_transition_sfx )
	_populate_attack_container( owner._attacks )


func _ready() -> void:
	_turn_system.turn_order_calculated.connect( _populate_character_list )
	_turn_system.turn_started.connect( _on_step_turn )
