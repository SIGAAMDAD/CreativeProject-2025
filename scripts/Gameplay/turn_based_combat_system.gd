class_name TurnBasedCombatSystem extends Object

var _current_turn: int = 0

signal turn_ended( team: Team )
signal turn_started( team: Team )

func calc_collective_initiative_bonus( team: Team ) -> int:
	var _initiative: int = 0
	for member in team._members:
		_initiative += member._stats._dexterity._modifier
	return _initiative

#
# ===============
# calc_first_attacker
# ===============
#
func calc_first_attacker() -> Team:
	var _team_player_initiative_bonus: int = calc_collective_initiative_bonus( CharacterData._player_team )
	var _team_player_initiative_actual: int = DiceGlobal.D20.roll() + _team_player_initiative_bonus
	
	var _team_enemy_initiative_bonus: int = calc_collective_initiative_bonus( CharacterData._enemy_team )
	var _team_enemy_initiative_actual: int = DiceGlobal.D20.roll() + _team_enemy_initiative_bonus
	
	if _team_player_initiative_actual > _team_enemy_initiative_actual:
		return CharacterData._player_team
	return CharacterData._enemy_team


#
# ===============
# _on_turn_begin
# ===============
#
func _on_turn_begin() -> void:
	pass


#
# ===============
# step
# ===============
#
func step() -> void:
	pass


#
# ===============
# begin_combat
# ===============
#
func begin_combat() -> void:
	pass


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	pass
