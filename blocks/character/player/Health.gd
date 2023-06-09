extends Node

@export var max_health = 3
@export var hurt_transparency = 0.6
@export var move_input: MoveInput
@export var trigger_area: Area3D
@export var timer: Timer
@export var block_dude: BlockDudeRelay
@export var hurt_material: Material

@onready var health = max_health

func _handle_death() -> void:
  move_input.disable()
  GameEvents.on_all_health_lost.emit()
  

func _on_area_3d_area_entered(area:Area3D):
  if not area is EnemyArea:
    return
  if timer.time_left > 0:
    return
  health -= 1
  if health <= 0:
    _handle_death()
    return
  GameEvents.on_health_lost.emit()
  block_dude.mesh.material_override = hurt_material
  timer.start()
  await timer.timeout
  block_dude.mesh.material_override = null
  timer.stop()
  block_dude.mesh.transparency = 0.0

