extends Control

const CHARACTER_SELECT = "res://scenes/main/character_select.tscn"
const MIN_LOAD_TIME = 2.0

var elapsed := 0.0
var load_complete := false
var target_scene: String = ""

func _ready():
	# Decide where to go first, then preload that scene
	if globals.has_save():
		globals.load_game()
		target_scene = globals.last_scene
	else:
		target_scene = CHARACTER_SELECT

	ResourceLoader.load_threaded_request(target_scene)

func _process(delta):
	elapsed += delta

	var progress = []
	var status = ResourceLoader.load_threaded_get_status(target_scene, progress)

	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		$ProgressBar.value = progress[0] * 100
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		$ProgressBar.value = 100
		load_complete = true

	if load_complete and elapsed >= MIN_LOAD_TIME:
		var scene = ResourceLoader.load_threaded_get(target_scene)
		get_tree().change_scene_to_packed(scene)
