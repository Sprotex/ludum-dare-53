extends RigidBody3D

class_name Box

@export var mesh: MeshInstance3D
@export var timer: Timer
@export var explosion_sphere: Area3D
@export var floored_material: Material

var was_refrozen_since_instantiation = false

func is_deliverable() -> bool:
  return !was_refrozen_since_instantiation and !freeze


func change_visual_scale(new_scale: Vector3) -> void:
  mesh.scale = new_scale


func move_to(node: Node3D) -> void:
  node.add_child(self)
  global_position = node.global_position
  global_rotation = node.global_rotation


func _on_sleeping_state_changed():
  if not sleeping:
    return
  if freeze:
    return
  mesh.material_override = floored_material
  was_refrozen_since_instantiation = true

func _explode() -> void:
  for body in explosion_sphere.get_overlapping_bodies():
    if not body is RigidBody3D and not body is CharacterBody3D:
      continue
    if body == LevelReference.level.player:
      continue
    var direction = body.global_position - global_position
    var direction_magnitude = direction.length()
    var blast_power = 50.0
    var inverse_distance = 1 / direction_magnitude
    var impulse_magnitude = blast_power * inverse_distance * inverse_distance
    var impulse = impulse_magnitude * direction.normalized()
    if body is RigidBody3D:
      body.apply_central_impulse(impulse)
      continue
    body.velocity += impulse
  GameEvents.on_box_exploded.emit(global_position)
  queue_free()


func start_explosion_countdown() -> void:
  timer.start()
  await timer.timeout
  _explode()


func _on_body_entered(_colliding_body:Node):
  GameEvents.on_box_collided.emit(global_position, linear_velocity)
