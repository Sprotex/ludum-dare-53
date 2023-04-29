extends Node3D

@export var player: CharacterBody3D
@export var boxes: Node3D
@export var camera: Camera3D
@export var enemies: Node3D

func _on_tree_entered():
	LevelReference.level = self
