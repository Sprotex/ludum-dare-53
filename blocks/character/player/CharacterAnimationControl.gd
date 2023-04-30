extends Node

class_name CharacterAnimationControl

@export var animation_relay: BlockDudeRelay
@export var box_weilder: BoxWeilder
@export var body: CharacterBody3D
@export var walking: Walking
@export var default_animation_blend_speed = 5.0

@onready var animation_tree = animation_relay.animation_tree
var carry_blend_amount = 0.0
var fall_blend_amount = 0.0

func _handle_run_parameter() -> void:
  var animation_speed = remap(body.velocity.length(), 0.0, walking.speed, 0.0, 1.0)
  animation_tree.set("parameters/movement/blend_amount", animation_speed)

func _handle_carry_parameter(delta: float) -> void:
  carry_blend_amount = move_toward(carry_blend_amount, box_weilder.has_box(), delta * default_animation_blend_speed)
  animation_tree.set("parameters/carry/blend_amount", carry_blend_amount)
  
func _handle_fall_parameter(delta: float) -> void:
  fall_blend_amount = move_toward(fall_blend_amount, not body.is_on_floor(), delta * default_animation_blend_speed)
  animation_tree.set("parameters/falling/blend_amount", fall_blend_amount)
  

func _process(delta: float) -> void:
  _handle_run_parameter()
  _handle_carry_parameter(delta)
  _handle_fall_parameter(delta)
