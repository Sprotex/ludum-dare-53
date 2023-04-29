extends Node3D

class_name Spawner

@export var timer: Timer
@export var path_follow: PathFollow3D
@export var enemy_scene: PackedScene
@export var start_time := 2.0
@export var increase_time_after_timeout := 2.0

@onready var randomizer = RandomNumberGenerator.new()


func spawn() -> void:
  var instance = enemy_scene.instantiate()
  path_follow.progress_ratio = randomizer.randf()
  LevelReference.level.enemies.add_child(instance)
  instance.global_position = path_follow.global_position


func _timer_finished() -> void:
  spawn()
  timer.wait_time += increase_time_after_timeout
  timer.start()


func _ready() -> void:
  get_tree().create_timer(start_time).timeout.connect(_timer_finished)
  timer.timeout.connect(_timer_finished)
