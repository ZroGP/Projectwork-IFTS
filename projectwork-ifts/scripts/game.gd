extends Node

var mess_nodes: Array = []
var stress_bar: TextureProgressBar = null
var last_active_count: int = 0
var coin_label: Label = null

func _ready() -> void:
	# 1. Setup UI based on character 
	if globals.player_character.contains("female"):
		$CanvasLayer/ui_menu_female.show()
		$CanvasLayer/ui_menu_male.hide()
		stress_bar = $CanvasLayer/ui_menu_female/Stress
		coin_label = $CanvasLayer/ui_menu_female/Female_Shop_Home/V_Shop_Home/H_Shop_Home/NinePatchRect/Coin_Count
	else:
		$CanvasLayer/ui_menu_female.hide()
		$CanvasLayer/ui_menu_male.show()
		stress_bar = $CanvasLayer/ui_menu_male/Stress
		# Double check this path in your editor if it was copied from female UI 
		coin_label = $CanvasLayer/ui_menu_male/Male_Shop_Home/V_Shop_Home/H_Shop_Home/NinePatchRect/Coin_Count

	# 2. Spawn character 
	if globals.player_character != "":
		var character = load(globals.player_character).instantiate()
		add_child(character)
		character.position = Vector2(430, -140)
		character.add_to_group("player")
	
	# 3. Initialize mess nodes and listen for signals 
	for child in $mess/mess.get_children():
		if child is Area2D:
			mess_nodes.append(child)
			child.mess_cleaned.connect(_on_mess_cleaned)

	$mess/Timer.timeout.connect(_on_timer_timeout)
	$mess/Timer.start()

func _process(_delta: float) -> void: 
	_update_stress_logic()
	_update_coin_ui()

func _update_stress_logic():
	if not stress_bar:
		return

	var active_count: int = 0
	for m in mess_nodes:
		if m._is_active:
			active_count += 1

	if active_count != last_active_count:
		var change = active_count - last_active_count
		var amount_per_object = 16.0
		var target_value = stress_bar.value - (change * amount_per_object)
		target_value = clamp(target_value, 0, stress_bar.max_value)

		var tween = create_tween()
		tween.tween_property(stress_bar, "value", target_value, 0.4)\
			.set_trans(Tween.TRANS_SINE)\
			.set_ease(Tween.EASE_OUT)

		last_active_count = active_count

func _update_coin_ui():
	if coin_label:
		coin_label.text = str(globals.coins)
		
		# Change color if limit is reached 
		if globals.coins >= globals.MAX_COINS:
			coin_label.modulate = Color.RED 
		else:
			coin_label.modulate = Color.WHITE 
		
func _on_timer_timeout() -> void:
	var available: Array = []
	for m in mess_nodes:
		if not m._is_active:
			available.append(m)

	if not available.is_empty():
		var pick: Area2D = available[randi() % available.size()]
		pick.show_mess()

func _on_mess_cleaned():
	$mess/Timer.stop()
	await get_tree().create_timer(3.0).timeout
	$mess/Timer.start()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F5: 
			DirAccess.remove_absolute(globals.SAVE_PATH)
