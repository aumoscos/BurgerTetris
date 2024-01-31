extends Node2D

var ingrediente1 = preload("res://Ingredientes/ingrediente_1.tscn") #carne
var ingrediente2 = preload("res://Ingredientes/ingrediente_2.tscn")
var ingrediente3 = preload("res://Ingredientes/ingrediente_3.tscn")
var ingrediente4 = preload("res://Ingredientes/ingrediente_4.tscn") #lechuga
var panSuperior = preload("res://Ingredientes/pan_superior.tscn")
var ingrediente5 = preload("res://Ingredientes/ingrediente_5.tscn")
var ingrediente6 = preload("res://Ingredientes/ingrediente_6.tscn")
var ingrediente7 = preload("res://Ingredientes/ingrediente_7.tscn") #queso
var ingrediente8 = preload("res://Ingredientes/ingrediente_8.tscn")
var ingrediente9 = preload("res://Ingredientes/ingrediente_9.tscn") #tocino
var ingrediente10 = preload("res://Ingredientes/ingrediente_10.tscn") #champiñones
var ingrediente11 = preload("res://Ingredientes/ingrediente_11.tscn")
var ingrediente12 = preload("res://Ingredientes/ingrediente_12.tscn")
var ingrediente13 = preload("res://Ingredientes/ingrediente_13.tscn")
var ingrediente14 = preload("res://Ingredientes/ingrediente_14.tscn")
var ingrediente15 = preload("res://Ingredientes/ingrediente_15.tscn") #tomate
var ingrediente16 = preload("res://Ingredientes/ingrediente_16.tscn")
var ingrediente17 = preload("res://Ingredientes/ingrediente_17.tscn")
var ingrediente18 = preload("res://Ingredientes/ingrediente_18.tscn")
var ingrediente19 = preload("res://Ingredientes/ingrediente_19.tscn")
var ingrediente20 = preload("res://Ingredientes/ingrediente_20.tscn")
var ingrediente21 = preload("res://Ingredientes/ingrediente_21.tscn")

var pan1Tapa = preload("res://Ingredientes/pan1Tapa.tscn")

@onready var orden1 = $Orden
@onready var orden2 = $Orden3
@onready var orden3 = $Orden4

var ingredientes = [ingrediente1, ingrediente4, ingrediente7, ingrediente9, ingrediente10, ingrediente15]

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
var dictIngredientes = {0:"carne", 1:"lechuga", 2:"queso",3:"tocino",4:"champinon",5:"tomate"}
var instCounter = 0

func _ready():
	var rnum = rng.randi_range(0, 5)
	var instance = ingredientes[rnum].instantiate()
	lastgen = rnum
	instance.position = Vector2(601,16)
	add_child(instance)
	lastInstance= instance


#Variables para temporizador y puntaje
var segundos = 300
var puntaje = 0
@onready var puntajeLabel = $Puntaje

#funcion para Temporizador
func updateTime():
	segundos -=1
	get_tree().get_nodes_in_group("temporizador")[0].text = "TIME = " + str(segundos)
	if segundos == 0:
		get_tree().change_scene_to_file("res://Scenes/MainTimeOut.tscn")

		

func inst(pos):
		var rnum = rng.randi_range(0, 5)
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

func cerrarHamburguesa(hamb, hambInst):
	hambInst.append(lastInstance)
	var completa = []
	for ingrediente in hamb:
		completa.append(ingrediente)
	hamburguesas.append(completa)
	comparar_con_orden(completa, orden1)
	comparar_con_orden(completa, orden2)
	comparar_con_orden(completa, orden3)
	print(hamburguesas)
	for inst in hambInst:
		inst.queue_free()
	hambInst.clear()
	hamb.clear()

func comparar_con_orden(hamb, orden):
	var cumple = true
	print(orden.generated_ingredients[0][1])
	for key in dictIngredientes:
			var nombre = dictIngredientes[key]
			var cantidad=hamb.count(key)
			for ingredient in orden.generated_ingredients:
				if(ingredient[0]==nombre):
					if(cantidad != ingredient[1]):
						cumple = false
	print(cumple)
	if(cumple == true):
		puntaje+=orden.get_costo()
		orden.setCompletada()
		puntajeLabel.text=str(puntaje)
	print(puntaje)

func _on_pan_1_body_entered(body):
	if(panNext==10):
		cerrarHamburguesa(hamb1, hamb1Instances)
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
		cerrarHamburguesa(hamb2, hamb2Instances)
		emit_signal("hamb2Completada")
	else:
		hamb2.append(lastgen)
		hamb2Instances.append(lastInstance)
		emit_signal("pan2")

	body.set_physics_process(false)
	await get_tree().create_timer(2).timeout
	inst(Vector2(601,16))
	
	
	


func _on_pan_3_body_entered(body):
	if(panNext==10):
		cerrarHamburguesa(hamb3, hamb3Instances)
		emit_signal("hamb3Completada")
	else:
		hamb3.append(lastgen)
		hamb3Instances.append(lastInstance)
		emit_signal("pan3")
	body.set_physics_process(false)
	await get_tree().create_timer(2).timeout
	inst(Vector2(601,16))
	

