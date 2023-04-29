extends Node

@export var body: CharacterBody3D
@export var camera: Camera3D
@export var speed := 5.0
@export var jump_velocity := 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _handle_gravity(delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y -= gravity * delta

func _handle_jump(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and body.is_on_floor():
		body.velocity.y = jump_velocity

func _physics_process(delta: float) -> void:
	_handle_gravity(delta)
	_handle_jump(delta)
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var right_direction = camera.transform.basis.x
	var forward_direction = right_direction.cross(Vector3.UP)
	var direction = (input_direction.x * right_direction + forward_direction * input_direction.y).normalized()
	if direction:
		body.velocity.x = direction.x * speed
		body.velocity.z = direction.z * speed
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, speed)
		body.velocity.z = move_toward(body.velocity.z, 0, speed)
	body.move_and_slide()
