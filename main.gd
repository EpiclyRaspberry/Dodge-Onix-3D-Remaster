extends Node3D

@onready var fpslabel = $CharacterBody3D/Neck/Camera3D/Control/fpslabel
@onready var mvmntctrls = $CharacterBody3D/Neck/Camera3D/Control/mvmnt

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_window().size)
	# it must be a float
	var a: float = get_window().size.y/3
	print((a))
	a = a/264
	print(a)
	mvmntctrls.set_scale(Vector2(a,a))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fpslabel.set_text("FPS: %d" % Engine.get_frames_per_second())
