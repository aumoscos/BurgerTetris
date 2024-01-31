extends Area2D

#var orden = Main.orden1

func _on_node_2d_pan_1():
	position.y-=27


func _on_node_2d_hamb_1_completada():
	position.y = 600
	print(Main.orden1)
