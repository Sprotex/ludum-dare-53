extends Node

class_name Jumping

@export var body: CharacterBody3D
@export var jump_velocity := 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _handle_gravity(delta: float) -> void:
  if not body.is_on_floor():
    body.velocity.y -= gravity * delta


func _handle_jump(_delta: float) -> void:
  if Input.is_action_just_pressed("jump") and body.is_on_floor():
    body.velocity.y = jump_velocity
    GameEvents.on_jumped.emit(body.global_position)


func _physics_process(delta: float) -> void:
  _handle_gravity(delta)
  _handle_jump(delta)