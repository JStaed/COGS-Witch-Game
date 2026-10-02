extends CharacterBody2D


const SPEED = 400.0
const ACCELERATION = 0.3


func _physics_process(_delta: float) -> void:
	_movement()


func _movement() -> void:
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	if direction:
		velocity = lerp(velocity, direction * SPEED, ACCELERATION)
	else:
		velocity = lerp(velocity, Vector2.ZERO, ACCELERATION)
	move_and_slide()
