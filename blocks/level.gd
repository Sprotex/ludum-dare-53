extends Node3D

@export var player: CharacterBody3D
@export var boxes: Node3D
@export var camera: Camera3D
@export var enemies: Node3D
@export var spawner: Spawner

func _on_tree_entered():
	LevelReference.level = self


func _on_restart_button_pressed():
	GameEvents.on_restarted.emit()
	get_tree().reload_current_scene()
