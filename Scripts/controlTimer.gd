extends Timer

signal segundo


func _on_timeout():
	emit_signal("segundo")
