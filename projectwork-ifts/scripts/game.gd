extends Node

var mess_nodes: Array = []

func _ready() -> void:
	# Show the correct UI and hide the other
	if globals.player_character.contains("female"):
		$CanvasLayer/ui_menu_female.show()
		$CanvasLayer/ui_menu_male.hide()
	else:
		$CanvasLayer/ui_menu_female.hide()
		$CanvasLayer/ui_menu_male.show()

	# Spawn character at the same position it had in the editor
	if globals.player_character != "":
		var character = load(globals.player_character).instantiate()
		add_child(character)
		character.position = Vector2(430, -140)
		character.add_to_group("player")
		print("character spawned at: ", character.position)
	else:
		print("WARNING: player_character is empty, no character spawned")

	# floor_mess nodes are inside mess/mess
	for child in $mess/mess.get_children():
		if child is Area2D:
			mess_nodes.append(child)
	print("mess_nodes found: ", mess_nodes.size())

	# Timer is a direct child of mess
	$mess/Timer.timeout.connect(_on_timer_timeout)
	$mess/Timer.start()

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
