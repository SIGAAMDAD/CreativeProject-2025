class_name CharacterStats extends Resource

@export var _name: String

@export var _strength: CharacterStat
@export var _dexterity: CharacterStat
@export var _intelligence: CharacterStat
@export var _wisdom: CharacterStat
@export var _charisma: CharacterStat

var _arcana: CharacterSkill = CharacterSkill.new()
var _athletics: CharacterSkill = CharacterSkill.new()
var _deception: CharacterSkill = CharacterSkill.new()
var _insight: CharacterSkill = CharacterSkill.new()
var _persuasion: CharacterSkill = CharacterSkill.new()
var _stealth: CharacterSkill = CharacterSkill.new()
var _medicine: CharacterSkill = CharacterSkill.new()
var _intimidation: CharacterSkill = CharacterSkill.new()
var _investigation: CharacterSkill = CharacterSkill.new()

var _initiative: int = 0

@export var _attacks: Array[ AttackData ]

@export var _mugshot: Texture2D


#
# ===============
# save
# ===============
#
func save( file: FileAccess ) -> void:
	file.store_32( _strength._score )
	file.store_32( _dexterity._score )
	file.store_32( _intelligence._score )
	file.store_32( _wisdom._score )
	file.store_32( _charisma._score )

	calc_stats()


#
# ===============
# load
# ===============
#
func load( file: FileAccess ) -> void:
	_strength.load( file.get_32() )
	_dexterity.load( file.get_32() )
	_intelligence.load( file.get_32() )
	_wisdom.load( file.get_32() )
	_charisma.load( file.get_32() )

	calc_stats()


#
# ===============
# calc_stats
# ===============
#
func calc_stats() -> void:
	_initiative = _dexterity._modifier

	_arcana.calc_modifier( _intelligence )
	_athletics.calc_modifier( _strength )
	_deception.calc_modifier( _charisma )
	_insight.calc_modifier( _wisdom )
	_intimidation.calc_modifier( _charisma )
	_investigation.calc_modifier( _intelligence )
	_medicine.calc_modifier( _wisdom )
	_persuasion.calc_modifier( _charisma )
	_stealth.calc_modifier( _dexterity )
