class_name HeadsUpDisplay extends CanvasLayer

@export var _player: PlayerCharacter

const CHARACTER_LIST_ENTRY_SCENE: PackedScene = preload( "res://scenes/character_data.tscn" )

func _add_character_to_list( data: CharacterStats, list: VBoxContainer ) -> void:
	var _entry: HBoxContainer = CHARACTER_LIST_ENTRY_SCENE.instantiate()
	_entry.get_node( "Mugshot" ).texture = data._mugshot
	_entry.get_node( "Name" ).text = data._name
	list.add_child( _entry )


func _populate_character_list() -> void:
	var _list: VBoxContainer = get_node( "MarginContainer/CharacterList" )
	
	_add_character_to_list.call_deferred( get_node( "/root/ActiveScene/PlayerCharacter" )._stats, _list )
	for date_npc in CharacterData._date_choices:
		_add_character_to_list.call_deferred( date_npc._stats, _list )


func _ready() -> void:
	_populate_character_list.call_deferred()
