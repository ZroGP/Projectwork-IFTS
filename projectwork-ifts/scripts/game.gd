extends Node

var mess_nodes: Array = []

func _ready() -> void:
	#Take all "floor_mess" inside the mess node
	for child in $mess.get_children():
		if child is Area2D:
			mess_nodes.append(child)
	print("mess_nodes found: ", mess_nodes.size())

	$Timer.start()

func _on_timer_timeout() -> void:
	print("timer fired, mess_nodes: ", mess_nodes.size())

	var available: Array = []
	for m in mess_nodes:
		if not m._is_active:
			available.append(m)

	print("available: ", available.size())

	if available.is_empty():
		return

	var pick: Area2D = available[randi() % available.size()]
	pick.show_mess()
	print("spawned: ", pick.name)
