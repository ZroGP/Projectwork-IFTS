extends Node

const MAX_COINS: int = 9999
var coins: int = 300:
	set(value):
		coins = clamp(value, 0, MAX_COINS)

# MASTER SWITCH: When true, player cannot move or interact
var is_ui_active: bool = false 

var player_name: String = ""
var player_character: String = "" 
var last_scene: String = ""

const SAVE_PATH = "user://save.cfg"

func add_coins(amount: int):
	coins = clamp(coins + amount, 0, MAX_COINS)
	print("Coins updated: ", coins)

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
	coins            = config.get_value("player", "coins",      0) 
	return true

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)
