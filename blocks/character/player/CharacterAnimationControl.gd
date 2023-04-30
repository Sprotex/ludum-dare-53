extends Node

@export var animation_relay: AnimationPlayerRelay
@export var box_weilder: BoxWeilder
@export var body: CharacterBody3D
@export var walking: Walking
@export var default_animation_blend_speed = 0.2

@onready var animation_tree = animation_relay.animation_tree

func _handle_run_parameter() -> void:
  var animation_speed = remap(body.velocity.length(), 0.0, walking.speed, 0.0, 1.0)
  animation_tree.set("parameters/movement/blend_amount", animation_speed)
  

func _process(_delta: float) -> void:
  _handle_run_parameter()
