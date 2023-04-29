extends Node

@export var box_weilder: BoxWeilder
@export var body: CharacterBody3D


func _on_visible_on_screen_notifier_3d_screen_exited():
  if not box_weilder.has_box():
    return
  body.queue_free()
