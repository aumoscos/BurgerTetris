extends Node



func _on_volver_a_jugar_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")


func _on_salir_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
