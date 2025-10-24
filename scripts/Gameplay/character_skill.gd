class_name CharacterSkill extends Resource

@export var _name: String
@export var _modifier: int = 0
@export var _proficient: bool = false

func calc_modifier( stat: CharacterStat ) -> void:
	_modifier = stat._modifier
