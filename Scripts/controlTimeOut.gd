extends Node



func _on_button_pressed():
	Main.resetTimer()
	Main.puntaje = 0
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
