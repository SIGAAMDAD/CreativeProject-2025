class_name SceneBase extends Node2D

const PAUSE_MENU = preload( "res://scenes/pause_menu.tscn" )


#
# ===============
# init_base
# ===============
#
func init_base() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child( PAUSE_MENU.instantiate() )
