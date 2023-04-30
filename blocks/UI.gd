extends Control

@export var restart_menu: Control
@export var score_label: Label


func _update_score_internal() -> void:
  score_label.text = "Boxes delivered: %d" % ScoreManager.current_score
  print(ScoreManager.current_score)


func _update_score(_position: Vector3, _mood: EnemyType.Mood) -> void:
  _update_score_internal()


func _handle_restart() -> void:
  restart_menu.hide()
  _update_score_internal()


func _ready():
  restart_menu.hide()
  _update_score_internal()
  GameEvents.on_restarted.connect(_handle_restart)
  GameEvents.on_package_delivered.connect(_update_score, CONNECT_DEFERRED)
  GameEvents.on_all_health_lost.connect(func(): restart_menu.show())
