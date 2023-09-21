extends CharacterBody3D


const SPEED = 5
const JUMP_VELOCITY = 4.5

var ACCERATION = 0

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D

func _unhandled_input(event: InputEvent) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01) 
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
			
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_pressed("crouch"):
		$CollisionShape3D.scale.y = 0.5
	else:
		$CollisionShape3D.scale.y = 1
		
	# Handle Jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		if ACCERATION < 1.5:
			ACCERATION += 0.1
		print(direction)
		velocity.x = direction.x * SPEED * ACCERATION
		velocity.z = direction.z * SPEED * ACCERATION
	else:
		velocity.x = velocity.x * ACCERATION 
		velocity.z = velocity.z * ACCERATION
		if ACCERATION > 0:
			ACCERATION -= 0.1

	print(velocity)

	move_and_slide()
