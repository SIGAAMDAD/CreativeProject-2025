class_name AttackData extends Resource

@export var _hit_chance: int = 0
@export var _hit_dice_multiplier: int = 0
@export var _hit_dice: Dice = null
@export var _scale_stat: CharacterStat.StatType
@export var _image: Texture2D


#
# ===============
# calc_damage
# ===============
#
func calc_damage( stats: CharacterStats ) -> void:
	var _scale: int = 0
	match _scale_stat:
		CharacterStat.StatType.Strength:
			_scale = stats._strength._modifier
		CharacterStat.StatType.Dexterity:
			_scale = stats._dexterity._modifier
		CharacterStat.StatType.Intelligence:
			_scale = stats._intelligence._modifier
		CharacterStat.StatType.Strength:
			_scale = stats._wisdom._modifier
	
	return _hit_dice.roll( _hit_dice_multiplier, _scale )


#
# ===============
# check_hit
# ===============
#
func check_hit( enemy_stats: CharacterStats, attacker_stats: CharacterStats ) -> bool:
	return enemy_stats._dexterity.check() > attacker_stats._dexterity.check()
