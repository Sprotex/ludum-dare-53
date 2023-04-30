extends Node

@export var box_weilder: BoxWeilder
@export var body: CharacterBody3D


func _on_visible_on_screen_notifier_3d_screen_exited():
  if not box_weilder.has_box() or body.is_on_floor():
    return
  LevelReference.level.spawner.spawn()
  body.queue_free()
