extends CharacterBody2D
@export var move_speed : float = 100

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		1.25
	)
	velocity = input_direction * move_speed
	move_and_slide()


