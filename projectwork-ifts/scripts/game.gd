extends Node

var mess_nodes: Array = []
var stress_bar: TextureProgressBar = null
var last_active_count: int = 0

# --- Dynamic Music References ---
var music_normal: AudioStreamPlayer = null
#var music_stress: AudioStreamPlayer = null
#var is_stress_music_active: bool = false

func _ready() -> void:
	# 1. Setup UI and Music for chosen character
	if globals.player_character.contains("female"):
		$CanvasLayer/ui_menu_female.show()
		$CanvasLayer/ui_menu_male.hide()
		stress_bar = $CanvasLayer/ui_menu_female/Stress
		music_normal = $MusicNormal
		#music_stress = $MusicStress
	else:
		$CanvasLayer/ui_menu_female.hide()
		$CanvasLayer/ui_menu_male.show()
		stress_bar = $CanvasLayer/ui_menu_male/Stress
		music_normal = $MusicNormal
		#music_stress = $MusicStress

	# 2. Initial Audio State
	#if music_normal:
		#music_normal.volume_db = 0.0
		#music_normal.play()
	#if music_stress:
		#music_stress.stop()

	# 3. Spawn character
	if globals.player_character != "":
		var character = load(globals.player_character).instantiate()
		add_child(character)
		character.position = Vector2(430, -140)
		character.add_to_group("player")
	
	# 4. Initialize mess nodes and listen for cleaning signal
	for child in $mess/mess.get_children():
		if child is Area2D:
			mess_nodes.append(child)
			# Connect to the new signal we added to floor_mess.gd
			child.mess_cleaned.connect(_on_mess_cleaned)

	$mess/Timer.timeout.connect(_on_timer_timeout)
	$mess/Timer.start()

func _process(_delta: float) -> void:
	if not stress_bar or not music_normal:#or not music_stress:
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
		
		# --- Sequential Music Switch ---
		#var threshold = stress_bar.max_value * 0.4 #value to change based on the stress now setted at 40% of the bar
		#if target_value <= threshold and not is_stress_music_active:
			#_switch_music_sequential(music_normal, music_stress)
			#is_stress_music_active = true
		#elif target_value > threshold and is_stress_music_active:
			#_switch_music_sequential(music_stress, music_normal)
			#is_stress_music_active = false

#func _switch_music_sequential(fade_out_node: AudioStreamPlayer, fade_in_node: AudioStreamPlayer) -> void:
	#var tween = create_tween()
	## Fade out current to silence
	#tween.tween_property(fade_out_node, "volume_db", -80.0, 0.5)
	## STOP it so it doesn't play in background
	#tween.tween_callback(fade_out_node.stop)
	## Start new one silent and fade it up
	#tween.tween_callback(fade_in_node.play)
	#tween.tween_property(fade_in_node, "volume_db", -80.0, 0.0)
	#tween.tween_property(fade_in_node, "volume_db", 0.0, 0.8)

func _on_timer_timeout() -> void:
	var available: Array = []
	for m in mess_nodes:
		if not m._is_active:
			available.append(m)

	if not available.is_empty():
		var pick: Area2D = available[randi() % available.size()]
		pick.show_mess()

func _on_mess_cleaned():
	# Stop the random generator for 5 seconds after cleaning
	$mess/Timer.stop()
	await get_tree().create_timer(3.0).timeout
	$mess/Timer.start()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F5:
			DirAccess.remove_absolute(globals.SAVE_PATH)
