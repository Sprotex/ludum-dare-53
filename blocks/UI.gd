extends Control

@export var restart_menu: Control

func _ready():
  restart_menu.hide()
  GameEvents.on_restarted.connect(func(): restart_menu.hide())
  GameEvents.on_all_health_lost.connect(func(): restart_menu.show())
