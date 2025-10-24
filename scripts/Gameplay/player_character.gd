class_name PlayerCharacter extends CharacterBody2D

@onready var _team: Team = $Team

var _stats: CharacterStats = null

#
# ===============
# set_preset
# ===============
#
func set_preset( preset: CharacterStats ) -> void:
	_stats = preset


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	pass
