extends Node

class_name BoxReceiver

@export var box_weilder: BoxWeilder
@export var walking: Walking
@export var move_input: MoveInput

signal on_box_received

func _ready():
  walking.on_collided_with_box.connect(_handle_colliding_with_box)


func _handle_colliding_with_box(box: Box) -> void:
  if not box.is_deliverable():
    return
  box_weilder.set_box(box)
  move_input.is_inverted = true
  on_box_received.emit()
  queue_free()
