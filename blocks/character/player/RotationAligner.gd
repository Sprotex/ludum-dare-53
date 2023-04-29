extends Node

class_name RotationAligner

@export var move_input: MoveInput
@export var alignment_speed = 10.0
@export var body: CharacterBody3D

func _physics_process(delta: float) -> void:
	var input_direction = move_input.direction
	if input_direction == null:
		return
	if input_direction.length_squared() <= 0.1:
		return
	
	var body_direction = -body.transform.basis.z
	var angle = body_direction.signed_angle_to(input_direction, Vector3.UP)
	if abs(angle) > alignment_speed:
		angle = sign(angle) * alignment_speed
	body.rotate_y(angle)
