extends Node

var mess_nodes: Array = []
var stress_bar: TextureProgressBar = null
var last_active_count: int = 0
var coin_label: Label = null

#this give the ui and spawn the player after the character selection, it also collects the mess in to the var mess_container for easy access
func _ready() -> void:
	#Setup ui based on character 
	if globals.player_character.contains("female"):
		$CanvasLayer/ui_menu_female.show()
		$CanvasLayer/ui_menu_male.hide()
		stress_bar = $CanvasLayer/ui_menu_female/Stress
		coin_label = $CanvasLayer/ui_menu_female/Female_Shop_Home/V_Shop_Home/H_Shop_Home/NinePatchRect/Coin_Count
	else:
		$CanvasLayer/ui_menu_female.hide()
		$CanvasLayer/ui_menu_male.show()
		stress_bar = $CanvasLayer/ui_menu_male/Stress
		coin_label = $CanvasLayer/ui_menu_male/Male_Shop_Home/V_Shop_Home/H_Shop_Home/NinePatchRect/Coin_Count

	if globals.player_character != "":
		spawn_player()
	
	# Initialize mess nodes 
	var mess_container = get_node_or_null("mess/mess")
	if mess_container:
		for child in mess_container.get_children():
			if child is Area2D:
				mess_nodes.append(child)
				child.mess_cleaned.connect(_on_mess_cleaned)
	else:
		pass  
	if has_node("mess/Timer"):
		$mess/Timer.timeout.connect(_on_timer_timeout)
		$mess/Timer.start()
	if coin_label:
		globals.set_meta("coin_label", coin_label)
func spawn_player():
	#loads the image of the character
	var character_scene = load(globals.player_character)
	#this adds the nodes to the player like CharacterBody2D, collision etc
	var player = character_scene.instantiate()
	
	# Add the player as child of the PlayerContainer
	$PlayerContainer.add_child(player) 
	
	# Use saved position if available, otherwise default
	if globals.last_position != Vector2.ZERO:
		player.position = globals.last_position
		print("Loading player at saved position: ", globals.last_position)
	else:
		player.position = Vector2(430, -140)
	
	await get_tree().process_frame
	
	# Find the specific joystick for the chosen gender
	var joystick_path = "CanvasLayer/ui_menu_female/Control_Joystick/JoystickFemale" if globals.player_character.contains("female") else "CanvasLayer/ui_menu_male/Control_Joystick/JoystickMale"
	var joystick_node = get_node_or_null(joystick_path)
	
	if joystick_node:
		player.joystick = joystick_node
		joystick_node.joystick_updated.connect(func(): player.direction = joystick_node.joystick_vector)
		joystick_node.joystick_end.connect(func(): player.direction = Vector2.ZERO)
	else:
		pass #this does nothig its just for the else
	
	_save_player_position_periodically(player)

# Save position every few seconds
func _save_player_position_periodically(player):
	while is_instance_valid(player):
		globals.update_player_position(player.position)
		await get_tree().create_timer(2.0).timeout
func _on_timer_timeout() -> void:
	var available: Array = []
	for m in mess_nodes:
		if not m._is_active:
			available.append(m)
	if not available.is_empty():
		available.pick_random().show_mess()
		_update_stress_logic()

# This updates the stress bar, coins and stops the timer, it also await 3 sec after you interact with a mess to start spawning again
func _on_mess_cleaned():
	$mess/Timer.stop()
	_update_stress_logic()
	_update_coin_ui()
	await get_tree().create_timer(3.0).timeout
	$mess/Timer.start()

# this is the strass bar func, where the bar goes down smoothly beacouse of tween so it dosent instantly go down
#you can decide how much it goes down everytime a mess spawns
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
		
