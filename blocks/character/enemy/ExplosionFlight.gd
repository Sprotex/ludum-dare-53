extends Node

@export var body: CharacterBody3D


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _handle_gravity(delta: float) -> void:
  if body.is_on_floor():
    return
  var height_of_no_return = 2.0
  var applied_force = gravity * delta
  if body.global_position.y > height_of_no_return:
    applied_force *= -1
  body.velocity.y -= applied_force


func _physics_process(delta: float) -> void:
  _handle_gravity(delta)