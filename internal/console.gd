extends Control

var click_pos = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mouseleft"):
			click_pos = get_local_mouse_position()	
	if Input.is_action_pressed("mouseleft"):
		position =(
			Vector2(position) +
			get_local_mouse_position() - 
			click_pos
		)

func logconsole(thing):
	$base/ScrollContainer/VBoxContainer.printer(thing)


func _on_mouse_entered():
	pass # Replace with function body.
