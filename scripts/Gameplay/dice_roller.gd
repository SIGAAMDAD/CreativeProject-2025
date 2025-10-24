class_name DiceRoller extends Node

#
# ===============
# roll_d20
# ===============
#
func roll_d20( modifier: int ) -> int:
	return randi_range( 1, 20 ) + modifier


#
# ===============
# roll_d12
# ===============
#
func roll_d12( modifier: int ) -> int:
	return randi_range( 1, 12 ) + modifier


#
# ===============
# roll_d10
# ===============
#
func roll_d10( modifier: int ) -> int:
	return randi_range( 1, 10 ) + modifier


#
# ===============
# roll_d8
# ===============
#
func roll_d8( modifier: int ) -> int:
	return randi_range( 1, 8 ) + modifier


#
# ===============
# roll_d4
# ===============
#
func roll_d4( modifier: int ) -> int:
	return randi_range( 1, 4 ) + modifier