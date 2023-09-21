extends CharacterBody3D


const SPEED = 5
const JUMP_VELOCITY = 4.5

var ACCERATION = 0

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D

func rotate_vec(vec: Vector2, angle_deg: int) -> Vector2:
	var rad = deg_to_rad(angle_deg)
	var nx = vec.x * cos(rad) - vec.y * sin(rad)
	var ny = vec.x * sin(rad) + vec.y * cos(rad)
	return Vector2(nx,ny)
	pass

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
		#print(direction)
		velocity.x = direction.x * SPEED * ACCERATION
		velocity.z = direction.z * SPEED * ACCERATION
	else:
		if ACCERATION > 0:
			ACCERATION -= 0.1
		var vec = rotate_vec(Vector2(ACCERATION,0),neck.rotation_degrees.y)
		print(vec)
		velocity = velocity + Vector3(vec.x,0,vec.y)
		print(velocity)
#		if ACCERATION > 0:
#			ACCERATION -= 0.075
			
	

	move_and_slide()




func _on_playercol_body_entered(body):
	if body.name == "ground":
		if Input.is_action_pressed("ui_accept") and Input.is_action_pressed("crouch") and not Input.is_action_pressed("back"):
			print("abh")
			velocity.z = velocity.z - 1
	pass # Replace with function body.
