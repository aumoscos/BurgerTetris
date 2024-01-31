extends Node2D

var ingrediente1 = preload("res://Ingredientes/ingrediente_1.tscn")
var ingrediente2 = preload("res://Ingredientes/ingrediente_2.tscn")
var ingrediente3 = preload("res://Ingredientes/ingrediente_3.tscn")
var ingrediente4 = preload("res://Ingredientes/ingrediente_4.tscn")
var panSuperior = preload("res://Ingredientes/pan_superior.tscn")
var ingrediente5 = preload("res://Ingredientes/ingrediente_5.tscn")
var ingrediente6 = preload("res://Ingredientes/ingrediente_6.tscn")
var ingrediente7 = preload("res://Ingredientes/ingrediente_7.tscn")
var ingrediente8 = preload("res://Ingredientes/ingrediente_8.tscn")
var ingrediente9 = preload("res://Ingredientes/ingrediente_9.tscn")
var ingrediente10 = preload("res://Ingredientes/ingrediente_10.tscn")
var ingrediente11 = preload("res://Ingredientes/ingrediente_11.tscn")
var ingrediente12 = preload("res://Ingredientes/ingrediente_12.tscn")
var ingrediente13 = preload("res://Ingredientes/ingrediente_13.tscn")
var ingrediente14 = preload("res://Ingredientes/ingrediente_14.tscn")
var ingrediente15 = preload("res://Ingredientes/ingrediente_15.tscn")
var ingrediente16 = preload("res://Ingredientes/ingrediente_16.tscn")
var ingrediente17 = preload("res://Ingredientes/ingrediente_17.tscn")
var ingrediente18 = preload("res://Ingredientes/ingrediente_18.tscn")
var ingrediente19 = preload("res://Ingredientes/ingrediente_19.tscn")
var ingrediente20 = preload("res://Ingredientes/ingrediente_20.tscn")
var ingrediente21 = preload("res://Ingredientes/ingrediente_21.tscn")

var pan1Tapa = preload("res://Ingredientes/pan1Tapa.tscn")


var ingredientes = [ingrediente1, ingrediente2, ingrediente3, ingrediente4, ingrediente5, ingrediente6, ingrediente7, ingrediente8, ingrediente9, ingrediente10, ingrediente11, ingrediente12, ingrediente13, ingrediente14, ingrediente15, ingrediente16, ingrediente17, ingrediente18, ingrediente19, ingrediente20, ingrediente21]
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
var hamburguesas = []
var dictIngredientes = {0:"carne", 1:"queso", 2:"lechuga",3:"huevo"}

func _ready():
	var rnum = rng.randi_range(0, 3)
	var instance = ingredientes[rnum].instantiate()
	lastgen = rnum
	instance.position = Vector2(601,16)
	add_child(instance)
	lastInstance= instance

#Variables para temporizador y puntaje
var segundos = 90
var puntaje = 0

#funcion para Temporizador
func updateTime():
	segundos -=1
	get_tree().get_nodes_in_group("temporizador")[0].text = "TIME = 0:" + str(segundos)
	if segundos == 0:
		get_tree().change_scene_to_file("res://Scenes/MainTimeOut.tscn")

		

func inst(pos):
	var rnum = rng.randi_range(0, 3)
	panNext = rng.randi_range(8,10)
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
		var completa = []
		for ingrediente in hamb1:
			completa.append(ingrediente)
		hamburguesas.append(completa)
		print(hamburguesas)
		for inst in hamb1Instances:
			inst.queue_free()
		hamb1Instances.clear()
		hamb1.clear()
		emit_signal("hamb1Completada")
	else:
		hamb1.append(lastgen)
		hamb1Instances.append(lastInstance)
		emit_signal("pan1")
		
	body.set_physics_process(false)
	await get_tree().create_timer(2).timeout
	inst(Vector2(601,16))
	
	



func _on_pan_2_body_entered(body):
	if(panNext==10):
		hamb2Instances.append(lastInstance)
		var completa = []
		for ingrediente in hamb2:
			completa.append(ingrediente)
		hamburguesas.append(completa)
		print(hamburguesas)
		for inst in hamb2Instances:
			inst.queue_free()
		hamb2Instances.clear()
		hamb2.clear()
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
		var completa = []
		for ingrediente in hamb3:
			completa.append(ingrediente)
		hamburguesas.append(completa)
		print(hamburguesas)
		for inst in hamb3Instances:
			inst.queue_free()
		hamb3Instances.clear()
		hamb3.clear()
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
	

