extends VBoxContainer

func printer(thing):
	print(thing)
	var dup = get_node("text").duplicate()
	dup.text = thing
	add_child(dup)
