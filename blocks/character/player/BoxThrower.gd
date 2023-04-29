extends Node

@export var box_weilder: BoxWeilder
@export var throw_power = 5.0
@export var throw_spin_power = 5.0
@export var body: CharacterBody3D

@onready var randomizer = RandomNumberGenerator.new()

func throw_box() -> void:
  var box = box_weilder.get_and_reset_box()
  box.freeze = false
  var box_global_position = box.global_position
  var box_global_rotation = box.global_rotation
  if not box.is_deliverable():
    box.start_explosion_countdown()
  box.get_parent().remove_child(box)
  LevelReference.level.boxes.add_child(box)
  box.remove_collision_exception_with(body)
  box.global_position = box_global_position
  box.global_rotation = box_global_rotation
  box.linear_velocity += -box_weilder.global_transform.basis.z * throw_power
  box.angular_velocity += Random.vector(randomizer) * throw_spin_power

func _process(_delta: float) -> void:
  if not Input.is_action_just_pressed("box_action"):
    return
  if not box_weilder.has_box():
    return
  throw_box.call_deferred()
