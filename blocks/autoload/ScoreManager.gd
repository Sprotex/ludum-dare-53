extends Node

var current_score = 0


func _ready():
  GameEvents.on_package_delivered.connect(func(_position, _mood): current_score += 1)
  GameEvents.on_restarted.connect(func(): current_score = 0)
