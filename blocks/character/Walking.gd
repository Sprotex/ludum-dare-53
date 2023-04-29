extends Node

class_name Walking

@export var body: CharacterBody3D
@export var speed := 5.0
@export var acceleration := 5.0
@export var jump_velocity := 4.5
@export var move_input: MoveInput
@export var inertia := 0.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

signal on_collided_with_box(box)


func _handle_two_way_collision_coupling() -> void:
	for collision_index in body.get_slide_collision_count():
		var collision = body.get_slide_collision(collision_index)
		if not collision:
			continue
		var collider = collision.get_collider()
		if not collider or not collider is RigidBody3D:
			continue
		var normal = collision.get_normal()
		var dot_product = normal.dot(Vector3.DOWN)
		if dot_product < -0.7:
			continue
		var position = collision.get_position()
		var local_position = body.global_position - position
		collider.apply_impulse(-normal * inertia, local_position)
		collider.apply_central_impulse(-normal * inertia * 0.5)
		if collider is Box:
			on_collided_with_box.emit(collider)


func _handle_gravity(delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y -= gravity * delta

func _handle_jump(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") and body.is_on_floor():
		body.velocity.y = jump_velocity


func _handle_walk(delta: float) -> void:
	var direction = move_input.direction
	if direction:
		var target_xz_velocity = Vector3(direction.x, 0.0, direction.z).normalized() * speed
		body.velocity.x = move_toward(body.velocity.x, target_xz_velocity.x, acceleration * delta)
		body.velocity.z = move_toward(body.velocity.z, target_xz_velocity.z, acceleration * delta)
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, acceleration * delta)
		body.velocity.z = move_toward(body.velocity.z, 0, acceleration * delta)


func _physics_process(delta: float) -> void:
	_handle_gravity(delta)
	_handle_jump(delta)
	_handle_walk(delta)
	body.move_and_slide()
	_handle_two_way_collision_coupling()		
