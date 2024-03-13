extends CharacterBody2D

const SPEED = 500.0

func _physics_process(delta):
	var x_direction = Input.get_axis("ui_left", "ui_right")
	var y_direction = Input.get_axis("ui_up", "ui_down")
	var direction = Vector2(x_direction, y_direction).normalized()
	velocity = direction * SPEED

	move_and_slide()
