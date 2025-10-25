class_name TurnBasedUI extends CanvasLayer

@onready var _character_list: VBoxContainer = $CharacterList
@onready var _character_details: MarginContainer = $CharacterDetails
@onready var _attack_container: HBoxContainer = $HBoxContainer

func _add_mugshot_to_character_list( stat: CharacterStats ) -> void:
	pass

func _populate_character_list() -> void:
	for member in CharacterData._player_team._members:
		_add_mugshot_to_character_list( member._stats )

func _ready() -> void:
	pass
