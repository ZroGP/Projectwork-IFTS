extends Node

func _on_timer_timeout() -> void:
	var oggetti = [
		$floor_mess1,
		$floor_mess2,
		$floor_mess3,
		$floor_mess4,
		$floor_mess5,
		$floor_mess6,
		$floor_mess7
	]

	# build a list of only objects that are not already visible
	var available = []
	for i in range(oggetti.size()):
		if not globals.array_check[i]:
			available.append(i)

	# if all objects are already spawned, do nothing
	if available.is_empty():
		return

	# pick randomly from available ones only
	var random = available[randi_range(0, available.size() - 1)]
	var obj = oggetti[random]
	obj.position.x = globals.array_x[random]
	obj.position.y = globals.array_y[random]
	obj.visible = true
	obj.get_node("CollisionPolygon2D").set_deferred("disabled", false)
	globals.array_check[random] = true
