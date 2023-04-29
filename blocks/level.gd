extends Node3D

@export var player: CharacterBody3D
@export var boxes: Node3D

func _on_tree_entered():
	LevelReference.level = self
