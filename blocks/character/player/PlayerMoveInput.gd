extends MoveInput

class_name PlayerMoveInput


func _set_direction() -> void:
  direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
  direction = _set_camera_transformed_direction()


func _set_camera_transformed_direction() -> Vector3:
  var camera = LevelReference.level.camera
  var right_direction = camera.global_transform.basis.x
  var forward_direction = right_direction.cross(Vector3.UP)
  var camera_transformed_direction = direction.x * right_direction + forward_direction * direction.y
  return camera_transformed_direction
  
