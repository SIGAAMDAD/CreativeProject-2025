class_name Dice extends Resource

@export var _max: int = 0

#
# ===============
# roll
# ===============
#
func roll( count: int = 1, modifier: int = 0 ) -> int:
	var _total: int = 0
	for index in count:
		_total += randi_range( 1, _max )
	return _total + modifier