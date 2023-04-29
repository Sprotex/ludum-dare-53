extends Node

class_name MoveInput

var direction
var camera_transformed_direction


func _process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var camera = LevelReference.level.camera
	var right_direction = camera.transform.basis.x
	var forward_direction = right_direction.cross(Vector3.UP)
	camera_transformed_direction = direction.x * right_direction + forward_direction * direction.y
