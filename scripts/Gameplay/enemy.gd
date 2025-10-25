class_name Enemy extends CharacterBody2D

@export var _data: EnemyData

@onready var _animations: AnimatedSprite2D = $AnimatedSprite2D


#
# ===============
# _ready
# ===============
#
func _ready() -> void:
	_animations.sprite_frames = _data._animation
#	get_node( "/root/ActiveScene/TurnBasedSystem" ).start_combat.connect( _on_combat_begin )
