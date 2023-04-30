extends Node

@export var animation_relay: AnimationPlayerRelay
@export var move_input: MoveInput
@export var box_weilder: BoxWeilder

@onready var animation_player = animation_relay.animation_player

const RUN_ANIMATION = "run"
const IDLE_ANIMATION = "idle"

func _handle_changing_animation(next_animation: String) -> void:
  var current_animation = animation_player.current_animation
  if current_animation == next_animation:
    return
  animation_player.play(next_animation)
  

func _handle_movement() -> void:
  if move_input.direction == null:
    return
  if move_input.direction.length_squared() <= 0.01:
    _handle_changing_animation(IDLE_ANIMATION)
    return
  _handle_changing_animation(RUN_ANIMATION)
  

func _process(_delta: float) -> void:
  _handle_movement()
