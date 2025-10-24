class_name CharacterStat extends Resource

enum StatType {
	Strength,
	Dexterity,
	Intelligence,
	Wisdom,
	Charisma,
}

@export var _score: int = 0
@export var _modifier: int = 0
@export var _type: StatType
@export var _name: String


#
# ===============
# calc
# ===============
#
func calc( score: int ) -> void:
	_score = score
	if score > 10:
		_modifier = ( ( score - 10 ) / 2 ) as int


#
# ===============
# check
# ===============
#
func check() -> int:
	return DiceGlobal.D20.roll( 1, _modifier )
