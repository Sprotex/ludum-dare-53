extends Node

class_name MoveInput

var is_inverted = false
var direction


func _set_direction() -> void:
	direction = Vector3.ZERO


func _process(_delta: float) -> void:
	_set_direction()
	if is_inverted:
		direction = -direction
