class_name CharacterCreator extends Control

const CHARACTER_CHOICE_CONTAINER = preload( "res://scenes/character_choice.tscn" )

var _selected_character: int = 0
var _character_presets: Array[ CharacterPreset ]

signal exit()

#
# ===============
# _list_files_in_directory
# ===============
#
func _list_files_in_directory( path: String ) -> Array[ String ]:
	var _files: Array[ String ] = []
	var _dir_access: DirAccess = DirAccess.open( path )

	if _dir_access != null:
		_dir_access.list_dir_begin()
		var _file_name: String = _dir_access.get_next()
		while _file_name != "":
			_files.push_back( path + "/" + _file_name )
			_file_name = _dir_access.get_next()
		_dir_access.list_dir_end()
	else:
		push_error( "Error: Could not open directory at path: " + path )
	
	return _files


#
# ===============
# _on_character_option_selected
# ===============
#
func _on_character_option_selected( index: int ) -> void:
	_selected_character = index
	
	_set_character_data()


func _set_character_data() -> void:
	var _character_photo: TextureRect = get_node( "VBoxContainer/InfoContainer/CharacterPhoto" )
	_character_photo.texture = _character_presets[ _selected_character ]._photo
	
	var _bio: Label = get_node( "VBoxContainer/InfoContainer/Bio" )
	_bio.text = _character_presets[ _selected_character ]._bio
	
	get_node( "VBoxContainer/InfoContainer" ).show()
	get_node( "VBoxContainer/BeginGameButton" ).show()


func _on_begin_game_pressed() -> void:
	CharacterData.set_player_preset( _character_presets[ _selected_character ] )
	get_tree().change_scene_to_file( "res://scenes/world/intro_scene.tscn" )


func _on_back_button_pressed() -> void:
	exit.emit()


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	var _character_options = get_node( "VBoxContainer/OptionsContainer" )
	var _presets_paths: Array[ String ] = _list_files_in_directory( "res://resources/character_presets" )
	var _index: int = 0
	for path in _presets_paths:
		var _choice: CharacterChoiceButton = CHARACTER_CHOICE_CONTAINER.instantiate()
		_choice._character_option = load( path )
		_choice.connect( "pressed", func(): _on_character_option_selected( _index ) )
		_character_options.add_child( _choice )
		_character_presets.push_back( _choice._character_option )
		
		print( "...Loaded character choice \"" + _choice._character_option._stats._name + "\"" )

		_index += 1
	
	get_node( "VBoxContainer/BeginGameButton" ).pressed.connect( _on_begin_game_pressed )
