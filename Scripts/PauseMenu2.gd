extends Control


var _is_paused: bool = false

func _ready():
	_is_paused = false
	get_tree().paused = false
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_is_paused = !_is_paused
		get_tree().paused = _is_paused
		visible = _is_paused

func _on_resume_game_pressed():
	_is_paused = false
	get_tree().paused = false
	visible = false

func _on_quit_game_pressed():
	_clean_up_game()
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _clean_up_game():
	_on_resume_game_pressed()
