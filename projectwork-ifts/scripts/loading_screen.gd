extends Control

#Addint loading time because the game is so light it almost skip the scene
const GAME_SCENE = "res://scenes/main/game.tscn"
const MIN_LOAD_TIME = 2.0  # seconds

var elapsed := 0.0
var load_complete := false

func _ready():
	ResourceLoader.load_threaded_request(GAME_SCENE)

func _process(delta):
	elapsed += delta
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(GAME_SCENE, progress)

	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		$ProgressBar.value = progress[0] * 100

	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		$ProgressBar.value = 100
		load_complete = true

	# Switch scenes when BOTH conditions are met
	if load_complete and elapsed >= MIN_LOAD_TIME:
		var game_scene = ResourceLoader.load_threaded_get(GAME_SCENE)
		get_tree().change_scene_to_packed(game_scene)
