extends Area2D

func on_interact(_player) -> void:
	var names = ["floor_mess1","floor_mess2","floor_mess3","floor_mess4","floor_mess5","floor_mess6","floor_mess7"]
	var idx = names.find(name)
	if idx != -1:
		globals.array_check[idx] = false

	$CollisionPolygon2D.set_deferred("disabled", true)
	visible = false
