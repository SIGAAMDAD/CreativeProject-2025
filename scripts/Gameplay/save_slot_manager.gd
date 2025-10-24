class_name SaveSlotManager extends Node

const MAX_SAVE_SLOTS: int = 3

class SlotInfo:
	var _time_accessed_year: int = 0
	var _time_accessed_month: Time.Month = Time.Month.MONTH_JANUARY
	var _time_accessed_day: Time.Weekday = Time.Weekday.WEEKDAY_MONDAY
	var _game_started: bool = false

	#
	# ===============
	# update
	# ===============
	#
	func update() -> void:
		var _created_time = Time.get_datetime_dict_from_system()
		_time_accessed_year = _created_time.year
		_time_accessed_month = _created_time.month
		_time_accessed_day = _created_time.weekday
	
	
	#
	# ===============
	# _init
	# ===============
	#
	func _init() -> void:
		update()


class SaveSlot:
	var _slot: int = 0
	var _exists: bool = false
	var _info: SlotInfo = SlotInfo.new()
	var _filepath: String

	#
	# ===============
	# _check_exists
	# ===============
	#
	func _check_exists() -> void:
		_filepath = "user://SaveData/data" + var_to_str( _slot ) + ".sav"
		_exists = FileAccess.file_exists( _filepath )
	
	
	#
	# ===============
	# _load_header
	# ===============
	#
	func _load_header() -> void:
		var _file: FileAccess = FileAccess.open( _filepath, FileAccess.READ )
		if _file != null:
			_info._time_accessed_year = _file.get_32()
			_info._time_accessed_month = _file.get_32() as Time.Month
			_info._time_accessed_day = _file.get_32() as Time.Weekday
			_info._game_started = _file.get_8()
		else:
			push_error( "Error loading save slot file!" )
		
		_file.close()
	

	#
	# ===============
	# _save_header
	# ===============
	#
	func _save_header() -> void:
		var _file: FileAccess = FileAccess.open( _filepath, FileAccess.WRITE )
		if _file != null:
			_info.update()
			
			_file.store_32( _info._time_accessed_year )
			_file.store_32( _info._time_accessed_month )
			_file.store_32( _info._time_accessed_day )
			_file.store_8( _info._game_started )
		else:
			push_error( "Error creating save slot file!" )
		
		_file.close()


	#
	# ===============
	# delete
	# ===============
	#
	func delete() -> void:
		DirAccess.remove_absolute( _filepath )
		_info._game_started = 0
		_info._time_accessed_year = 0
		_info._time_accessed_month = 0
		_info._time_accessed_day = 0
		_exists = false
	
	
	#
	# ===============
	# create
	# ===============
	#
	func create() -> void:
		_save_header()


	#
	# ===============
	# _init
	# ===============
	#
	func _init( slot: int ) -> void:
		_slot = slot
		_check_exists()
		if _exists:
			_load_header()

var _save_slots: Array[ SaveSlot ]
var _current_slot: int

signal save_game()
signal start_game()

#
# ===============
# _create_save_file
# ===============
#
func _create_save_file( slot: int ) -> void:
	print( "SaveSlotManager: initializing save slot..." )

	_current_slot = slot
	_save_slots[ _current_slot ].create()


#
# ===============
# init_save_slot
# ===============
#
func set_slot( slot: int ) -> void:
	print( "SaveSlotManager: set save slot to " + var_to_str( slot ) )

	if !_save_slots[ slot ]._exists:
		_create_save_file( slot )
	else:
		pass


#
# ===============
# has_progress_in_current_slot
# ===============
#
func has_progress_in_current_slot() -> bool:
	return _save_slots[ _current_slot ]._info._game_started


#
# ===============
# delete_slot
# ===============
#
func delete_slot( slot: int ) -> void:
	print( "SaveSlotManager: deleting save slot " + var_to_str( slot ) + "..." )
	if _save_slots[ slot ]._exists:
		_save_slots[ slot ].delete()


#
# ===============
# load
# ===============
#
func load() -> void:
	print( "SaveSlotManager: loading progress from archived state..." )

	var _nodes: Array[ Node ] = get_tree().get_nodes_in_group( "Archive" )
	for node in _nodes:
		if !node.has_method( "save" ):
			push_error( "SaveSlotManager: archive node " + node.name + " doesn't have the required \"save\" method!" )
		else:
			node.save()


#
# ===============
# save
# ===============
#
func save() -> void:
	save_game.emit()


#
# ===============
# get_progress
# ===============
#
func get_progress( slot: int ) -> SlotInfo:
	return _save_slots[ slot ]._info if _save_slots[ slot ]._exists else null


#
# ===============
# start_game
# ===============
#
func initialize_game() -> void:
	_save_slots[ _current_slot ]._info._game_started = true
	start_game.emit()


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	DirAccess.make_dir_recursive_absolute( "user://SaveData/" )

	for slot in MAX_SAVE_SLOTS:
		_save_slots.push_back( SaveSlot.new( slot ) )
