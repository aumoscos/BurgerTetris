extends Node2D

var ingrediente1 = preload("res://Ingredientes/ingrediente_1.tscn")
var ingrediente2 = preload("res://Ingredientes/ingrediente_2.tscn")
var ingrediente3 = preload("res://Ingredientes/ingrediente_3.tscn")
var ingrediente4 = preload("res://Ingredientes/ingrediente_4.tscn")
var ingredientes = [ingrediente1, ingrediente2, ingrediente3, ingrediente4]
var panSuperior = preload("res://Ingredientes/pan_superior.tscn")
var rng = RandomNumberGenerator.new()
var panNext = 0
var lastgen = 0
var lastInstance
signal pan1
signal pan2
signal pan3
signal hamb1Completada
signal hamb2Completada
signal hamb3Completada
var hamb1 = []
var hamb2 = []
var hamb3 = []
var hamb1Instances = []
var hamb2Instances = []
var hamb3Instances = []
func _ready():
	var rnum = rng.randi_range(0, 3)
	var instance = ingredientes[rnum].instantiate()
	lastgen = rnum
	instance.position = Vector2(601,16)
	add_child(instance)
	lastInstance= instance


func inst(pos):
	var rnum = rng.randi_range(0, 3)
	panNext = rng.randi_range(0,10)
	if(panNext<10):
		var instance = ingredientes[rnum].instantiate()
		lastgen = rnum
		instance.position = pos
		add_child(instance)
		lastInstance= instance
	else:
		var instance = panSuperior.instantiate()
		instance.position = pos
		add_child(instance)
		lastInstance= instance




func _on_pan_1_body_entered(body):
	
	if(panNext==10):
		hamb1Instances.append(lastInstance)
		print("Hamburguesa completada:")
		print(hamb1)
		for inst in hamb1Instances:
			inst.queue_free()
		hamb1Instances.clear()
		emit_signal("hamb1Completada")
	else:
		hamb1.append(lastgen)
		print(hamb1)
		hamb1Instances.append(lastInstance)
		print(hamb1Instances)
		emit_signal("pan1")
		
	body.set_physics_process(false)
	await get_tree().create_timer(2).timeout
	inst(Vector2(601,16))
	
	



func _on_pan_2_body_entered(body):
	if(panNext==10):
		hamb2Instances.append(lastInstance)
		print("Hamburguesa completada:")
		print(hamb2)
		for inst in hamb2Instances:
			inst.queue_free()
		hamb2Instances.clear()
		emit_signal("hamb2Completada")
	else:
		hamb2.append(lastgen)
		print(hamb2)
		hamb2Instances.append(lastInstance)
		print(hamb2Instances)
		emit_signal("pan2")

	body.set_physics_process(false)
	await get_tree().create_timer(2).timeout
	inst(Vector2(601,16))
	
	
	


func _on_pan_3_body_entered(body):
	if(panNext==10):
		hamb3Instances.append(lastInstance)
		print("Hamburguesa completada:")
		print(hamb3)
		for inst in hamb3Instances:
			inst.queue_free()
		hamb3Instances.clear()
		emit_signal("hamb3Completada")
	else:
		hamb3.append(lastgen)
		print(hamb3)
		hamb3Instances.append(lastInstance)
		print(hamb3Instances)
		emit_signal("pan3")
	body.set_physics_process(false)
	await get_tree().create_timer(2).timeout
	inst(Vector2(601,16))
	

