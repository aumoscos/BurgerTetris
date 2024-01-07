extends Node2D

var ingredients = [
	preload('res://Ingredientes/ingrediente_1.tscn'),
	preload('res://Ingredientes/ingrediente_2.tscn'),
]

var start_recipe_queue_pos = Vector2(100, 100)


func _init():
	print('Hello World!')
	print(ingredients)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print('ready to create a recipe')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
