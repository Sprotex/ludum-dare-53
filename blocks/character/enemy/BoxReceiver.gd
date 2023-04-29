extends Node

@export var box_weilder: BoxWeilder
@export var walking: Walking
@export var move_input: MoveInput


func _ready():
  walking.on_collided_with_box.connect(_handle_colliding_with_box)


func _handle_colliding_with_box(box: Box) -> void:
  if not box.is_deliverable():
    return
  box_weilder.set_box(box)
  move_input.is_inverted = true
  queue_free()
