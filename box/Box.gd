extends RigidBody3D

class_name Box

var was_refrozen_since_instantiation = false

func is_deliverable() -> bool:
	return was_refrozen_since_instantiation and freeze


func _on_sleeping_state_changed():
	freeze = true
	was_refrozen_since_instantiation = true