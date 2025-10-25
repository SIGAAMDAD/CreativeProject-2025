class_name CharacterCreator extends Control

const CHARACTER_CHOICE_CONTAINER: PackedScene = preload( "res://scenes/menus/widgets/character_choice.tscn" )

@onready var _character_options = $"VBoxContainer/OptionsContainer"

var _selected_character: int = 0
var _character_presets: Array[ CharacterPreset ]

signal set_menu_state( state: MenuSystem.State )

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
	get_parent()._on_ui_button_pressed()
	_set_character_data()


#
# ===============
# _set_character_data
# ===============
#
func _set_character_data() -> void:
	var _character_photo: TextureRect = get_node( "VBoxContainer/InfoContainer/CharacterPhoto" )
	_character_photo.texture = _character_presets[ _selected_character ]._photo
	
	var _bio: Label = get_node( "VBoxContainer/InfoContainer/Bio" )
	_bio.text = _character_presets[ _selected_character ]._bio
	
	get_node( "VBoxContainer/InfoContainer" ).show()
	get_node( "VBoxContainer/BeginGameButton" ).show()


#
# ===============
# _on_begin_game_button_pressed
# ===============
#
func _on_begin_game_button_pressed() -> void:
	CharacterData.set_player_preset( _character_presets[ _selected_character ] )
	get_tree().change_scene_to_file( "res://scenes/world/world.tscn" )


#
# ===============
# _on_back_button_pressed
# ===============
#
func _on_back_button_pressed() -> void:
	set_menu_state.emit( MenuSystem.State.Main )


func _setup_focus_navigation() -> void:
	var _index: int = 0
	for choice in _character_options.get_children():
		choice.focus_neighbor_bottom = choice.get_path()
		choice.focus_neighbor_top = choice.get_path()
		if _index == 0:
			choice.focus_neighbor_left = _character_options.get_child( _character_options.get_child_count() - 1 ).get_path()
			choice.focus_neighbor_right = _character_options.get_child( _index + 1 ).get_path()
		elif _index == _character_options.get_child_count() - 1:
			choice.focus_neighbor_left = _character_options.get_child( _index - 1 ).get_path()
			choice.focus_neighbor_right = _character_options.get_child( 0 ).get_path()
		else:
			choice.focus_neighbor_left = _character_options.get_child( _index - 1 ).get_path()
			choice.focus_neighbor_right = _character_options.get_child( _index + 1 ).get_path()
		
		_index += 1


#
# ===============
# _load_character_presets
# ===============
#
func _load_character_presets() -> void:
	print( "Loading character choices..." )
	
	for child in _character_options.get_children():
		_character_options.remove_child( child )
	
	var _preset_paths: Array[ String ] = _list_files_in_directory( "res://resources/character_presets" )
	var _index: int = 0
	for path in _preset_paths:
		var _choice: CharacterChoiceButton = CHARACTER_CHOICE_CONTAINER.instantiate()
		_choice._character_option = load( path )
#		_choice.pressed.connect( func(): _on_character_option_selected( _index ) )
		_choice.focused.connect( func(): _on_character_option_selected( _index ) )
		_character_options.add_child( _choice )
		_character_presets.push_back( _choice._character_option )
		
		print( "...Loaded character choice \"" + _choice._character_option._stats._name + "\"" )
		
		_index += 1
	
#	_setup_focus_navigation()
	
	print( "Got " + var_to_str( _preset_paths.size() ) + " character presets."  )


#
# ===============
# _on_visibility_changed
# ===============
#
func _on_visibility_changed() -> void:
	if visible:
		_load_character_presets()
		_character_options.get_child( 0 ).grab_focus()


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	set_meta( "index", MenuSystem.State.CharacterCreation )
