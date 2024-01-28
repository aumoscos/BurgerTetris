extends Node2D

var ingrediente1 = preload("res://Ingredientes/ingrediente_1.tscn")
var ingrediente2 = preload("res://Ingredientes/ingrediente_2.tscn")
var ingrediente3 = preload("res://Ingredientes/ingrediente_3.tscn")
var ingrediente4 = preload("res://Ingredientes/ingrediente_4.tscn")
var ingredientes = [ingrediente1, ingrediente2, ingrediente3, ingrediente4]
var rng = RandomNumberGenerator.new()
var lastgen = 0
signal pan1
signal pan2
signal pan3
var hamb1 = []
var hamb2 = []
var hamb3 = []



func inst(pos):
	var rnum = rng.randi_range(0, 3)
	var instance = ingredientes[rnum].instantiate()
	lastgen = rnum
	instance.position = pos
	add_child(instance)




func _on_pan_1_body_entered(body):
	
	hamb1.append(lastgen)
	print('Ham1', hamb1)
	
	body.set_physics_process(false)
	await get_tree().create_timer(2).timeout
	inst(Vector2(601,16))
	emit_signal("pan1")
	



func _on_pan_2_body_entered(body):
	hamb2.append(lastgen)
	print('Ham2', hamb2)

	body.set_physics_process(false)
	await get_tree().create_timer(2).timeout
	inst(Vector2(601,16))
	emit_signal("pan2")
	
	


func _on_pan_3_body_entered(body):
	hamb3.append(lastgen)
	print('Ham3', hamb3)
	body.set_physics_process(false)
	await get_tree().create_timer(2).timeout
	inst(Vector2(601,16))
	emit_signal("pan3")

