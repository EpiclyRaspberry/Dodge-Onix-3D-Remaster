extends Node3D

@onready var fpslabel = $CharacterBody3D/Neck/Camera3D/Control/fpslabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fpslabel.set_text("FPS: %d" % Engine.get_frames_per_second())
