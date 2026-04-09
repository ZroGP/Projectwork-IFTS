extends Node

# Starting coins (unchanged)
var coins: int = 270

# Character selection
var player_name: String = ""
var player_character: String = ""  # path to chosen character scene

var last_scene: String = ""

const SAVE_PATH = "user://save.cfg"

func save_game():
	var config = ConfigFile.new()
	config.set_value("player", "name",        player_name)
	config.set_value("player", "character",   player_character)
	config.set_value("player", "last_scene",  last_scene)
	config.set_value("player", "coins",       coins)
	config.save(SAVE_PATH)

func load_game() -> bool:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return false
	player_name      = config.get_value("player", "name",       "")
	player_character = config.get_value("player", "character",  "")
	last_scene       = config.get_value("player", "last_scene", "")
	coins            = config.get_value("player", "coins",      270)
	return true

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)
