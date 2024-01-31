extends Control


func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")
	pass # Replace with function body.


func _on_jugar_2_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	body.queue_free()
