extends MoveInput

class_name EnemyMoveInput


func _set_direction() -> void:
	var body = get_parent() as CharacterBody3D
	var player = LevelReference.level.player
	direction = player.global_position - body.global_position
	direction.y = 0.0
	if direction.length_squared() > 1.0:
		direction = direction.normalized()
