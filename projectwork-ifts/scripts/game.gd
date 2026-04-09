extends Node

var mess_nodes: Array = []

func _ready() -> void:
	# Spawn the chosen character once
	if globals.player_character != "":
		var character = load(globals.player_character).instantiate()
		add_child(character)
		character.add_to_group("player")
		print("character spawned and added to group: ", character.name)
	else:
		print("WARNING: player_character is empty, no character spawned")

	# Take all "floor_mess" inside the mess node (unchanged)
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

# Press F5 during play to wipe the save file
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F5:
			DirAccess.remove_absolute(globals.SAVE_PATH)
			print("Save deleted!")
