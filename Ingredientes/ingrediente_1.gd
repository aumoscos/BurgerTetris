extends CharacterBody2D
@export var move_speed : float = 100

func _physics_process(_delta):
	var input_direction = Vector2(
		0,
		1.25
	)
	velocity = input_direction * move_speed
	move_and_slide()
	if Input.is_action_just_pressed("Right"):
		if !(position.x > 700):
			position.x+=140
	if Input.is_action_just_pressed("Left"):
		if !(position.x < 500):	
			position.x-=140
	

