extends Node

signal on_stepped(position: Vector3)
signal on_jumped(position: Vector3)
signal on_package_delivered(position: Vector3, mood: EnemyType.Mood)
signal on_enemy_spawned(node: Node3D, mood: EnemyType.Mood)
signal on_box_collided(position: Vector3)
signal on_box_created(position: Vector3)