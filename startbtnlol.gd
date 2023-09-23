extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var c = get_parent()
	c.set_size(get_window().get_size())
	


func _on_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

