extends CharacterBody2D
@export var move_speed : float = 100

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("Up") - Input.get_action_strength("Down"),
		1.25
	)
	
	
	
	velocity = input_direction * move_speed
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	RigidBody2D.sleeping
