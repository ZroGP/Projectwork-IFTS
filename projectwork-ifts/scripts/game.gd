extends Node

var mess_nodes: Array = []
var stress_bar: TextureProgressBar = null
var last_active_count: int = 0

func _ready() -> void:
	# Show the correct UI, hide the other, grab stress bar
	if globals.player_character.contains("female"):
		$CanvasLayer/ui_menu_female.show()
		$CanvasLayer/ui_menu_male.hide()
		stress_bar = $CanvasLayer/ui_menu_female/Stress
	else:
		$CanvasLayer/ui_menu_female.hide()
		$CanvasLayer/ui_menu_male.show()
		stress_bar = $CanvasLayer/ui_menu_male/Stress

	# Spawn character
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

func _process(_delta: float) -> void:
	if not stress_bar:
		return

	# Count how many mess nodes are currently active
	var active_count: int = 0
	for m in mess_nodes:
		if m._is_active:
			active_count += 1

	# Only update stress bar when the count changes
	if active_count != last_active_count:
		var change = active_count - last_active_count
		var amount_per_object = 10.0
		var target_value = stress_bar.value - (change * amount_per_object)
		target_value = clamp(target_value, 0, stress_bar.max_value)

		var tween = create_tween()
		tween.tween_property(stress_bar, "value", target_value, 0.4)\
			.set_trans(Tween.TRANS_SINE)\
			.set_ease(Tween.EASE_OUT)

		last_active_count = active_count

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
