extends PathFollow3D

@export var enemy_scene: PackedScene

@onready var randomizer = RandomNumberGenerator.new()

func spawn() -> void:
	var instance = enemy_scene.instantiate()
	progress_ratio = randomizer.randf()
	LevelReference.level.enemies.add_child(instance)
	instance.global_position = global_position

func _process(_delta) -> void:
	if Input.is_key_pressed(KEY_CTRL):
		spawn()
