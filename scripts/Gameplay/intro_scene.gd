class_name IntroScene extends SceneBase

func _ready() -> void:
	init_base()
	
	SaveManager.initialize_game()
	SaveManager.save()
