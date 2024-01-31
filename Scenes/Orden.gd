extends Node2D

@onready var order_tile = $OrderTileMap
var completada = false
func setCompletada():
	completada = true
const PAPER_LAYER: int = 0
# El id del recurso para las texturas de la orden
const SOURCE_ID: int = 0

# El id del recurso para las texturas de los números
const ORDER_COUNT_ID: int = 1

const ingredientes_obligatorios = [
	'carne'	
]

const ingredientes_complementos = [
	'lechuga',
	#'carne',
	'champinon',
	'tocino',
	'queso',
	'tomate',
]

const ingredient_tile_location = {
	'carne':     [3, 0],
	'lechuga':   [3, 1],
	'tomate':    [3, 2],
	'queso':     [3, 3],
	'tocino':    [2, 3],
	'champinon': [1, 3]
}

const costo_ingrediente = {
	'carne':     1.25,
	'lechuga':   0.3,
	'tomate':    0.15,
	'queso':     0.25,
	'tocino':    0.85,
	'champinon': 0.35
}

const quantity_tileset = {
	1: Vector2i(0, 0),
	2: Vector2i(1, 0),
	3: Vector2i(2, 0),
	4: Vector2i(3, 0),
}

const completed_tileset = [
	Vector2i(0, 1), # (0)
	Vector2i(0, 2), # (1)
	Vector2i(1, 1),
	Vector2i(2, 1),
	Vector2i(3, 1),
]

"""
Define la cantidad máxima de ingredientes que se pueden generar.
No define cuantos ingredientes tiene el objetivo, si no cuantos
de los ingredientes seleccionados, se pueden agregar.
"""
@export var max_ingredient_count: int = 7


"""
Es el valor monetario del pedido, se genera en base a los ingredientes
generados, y quizás en la dificultad (por implementar).
"""
var valor_monetario: float = 0

var generated_ingredients = []

"""
Aquí se almacena el estado del pedido, con la cantidad máxima
"""
var order_state = {}

var RngGenerator = RandomNumberGenerator.new()

func to_vect(target: Array):
	return Vector2i(target[0], target[1])
	
func get_ingredients():
	return generated_ingredients
	
func get_ingredient_state(ingredient: String):
	return order_state[ingredient]
	
func update_ingredient(ingredient: String, delta: int):
	var target_state = order_state[ingredient]
	target_state['count'] += delta
	target_state['completed'] = target_state['count'] == target_state['max']
	target_state['failed'] = target_state['count'] > target_state['max']

func random_index(arr: Array):
	return RngGenerator.randi_range(0, arr.size())

func generar_ingredientes(quantity: int):
	ingredientes_obligatorios.shuffle()
	var ingredientes_pendientes = quantity - 1
	print('Ingredientes obligatorios aleatorizados en orden: ', ingredientes_obligatorios)
	var ingredientes_finales = []
	var obligatorio = ingredientes_obligatorios.pick_random()
	ingredientes_finales.append(obligatorio)
	if (RngGenerator.randfn() > 0.76458 and ingredientes_obligatorios.size() > 1):
		var ing_extra = ingredientes_obligatorios.pick_random()
		while ing_extra == obligatorio:
			ing_extra = ingredientes_obligatorios.pick_random()
		ingredientes_finales.append(ing_extra)
		ingredientes_pendientes -= 1
	var ingredientes_comp_list = ingredientes_complementos.duplicate()
	while ingredientes_pendientes > 0:
		ingredientes_comp_list.shuffle()
		var ingrediente = ingredientes_comp_list.pop_back()
		ingredientes_pendientes -= 1
		ingredientes_finales.append(ingrediente)
	return ingredientes_finales
		
"""
Retorna el valor que tiene la orden
"""
func get_costo(): 
	return valor_monetario


# Called when the node enters the scene tree for the first time.
func _ready():
	#RngGenerator.randomize()
	var generated = []
	var target_count = 4
	var ingredient_count = max_ingredient_count
	var ingredientes = generar_ingredientes(4)
	ingredientes.shuffle()
	while (target_count > 0):
		var objective_ingredient = ingredientes.pop_back()
		#var objective_ingredient = ingredientes[randi() % ingredientes.size()]
		print('Target ingredient: ', objective_ingredient)
		var generated_ing_props = [objective_ingredient, (randi() % target_count) + 1]
		generated.push_back(generated_ing_props)
		var state = {
			'count': 0,
			'max': generated_ing_props[1],
			'completed': false,
			'failed': false,
			'index': null
		}
		order_state[objective_ingredient] = state
		target_count -= 1
	
	# Ahora generamos el estado inicial de los ingredientes
	for i in range(generated.size()):
		# Contiene una tupla [ <ingrediente>: string, <quantity>: int ]
		var ingredient = generated[i]
		# Contiene una tupla [ <x>, <y> ] del mipmap a renderizar
		var target_atlas_location = ingredient_tile_location[ingredient[0]]
		print('The target atlas:', target_atlas_location, ' and the quantity: ', ingredient[1])
		print('The vector of atlas:', to_vect(target_atlas_location))
		var costo_ingrediente = costo_ingrediente[ingredient[0]] * ingredient[1]
		print('Costo del ingrediente ', ingredient[0], ' => $', costo_ingrediente)
		valor_monetario += costo_ingrediente
		order_state[ingredient[0]]['index'] = i
		order_tile.set_cell(PAPER_LAYER, Vector2(1, i+1), SOURCE_ID, to_vect(target_atlas_location))
		order_tile.set_cell(PAPER_LAYER, Vector2i(2, i+1), ORDER_COUNT_ID, quantity_tileset[ingredient[1]])
		order_tile.set_cell(PAPER_LAYER, Vector2i(3, i+1), ORDER_COUNT_ID, completed_tileset[0])
	#order_tile.force_update(PAPER_LAYER)
	print('generated ingredient list: ', generated)
	print('Total del costo de la orden: $', get_costo())
	generated_ingredients = generated


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for ingredient_name in order_state:
		var properties = order_state[ingredient_name]
		var i = properties['index']
		var completed_count = properties['count']
		order_tile.set_cell(PAPER_LAYER, Vector2i(3, i+1), ORDER_COUNT_ID, completed_tileset[completed_count])
