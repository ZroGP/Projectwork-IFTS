extends Node

const MAX_COINS: int = 9999
var coins: int = 300:
	set(value):
		coins = clamp(value, 0, MAX_COINS)

var is_ui_active: bool = false 

var player_name: String = ""
var player_character: String = "" 
var last_scene: String = ""
var last_position: Vector2 = Vector2.ZERO

const SAVE_PATH = "user://save.cfg"

func add_coins(amount: int):
	coins = clamp(coins + amount, 0, MAX_COINS)
	save_game()

func save_game():
	var config = ConfigFile.new()
	config.load(SAVE_PATH)  # Attempt to load existing to preserve other sections
	
	config.set_value("player", "name",        player_name)
	config.set_value("player", "character",   player_character)
	config.set_value("player", "last_scene",  last_scene)
	config.set_value("player", "coins",       coins)
	config.set_value("player", "position_x",  last_position.x)
	config.set_value("player", "position_y",  last_position.y)
	
	config.save(SAVE_PATH)

func load_game() -> bool:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return false
	player_name      = config.get_value("player", "name",       "")
	player_character = config.get_value("player", "character",  "")
	last_scene       = config.get_value("player", "last_scene", "")
	coins            = config.get_value("player", "coins",      0)
	var pos_x        = config.get_value("player", "position_x", 430.0)
	var pos_y        = config.get_value("player", "position_y", -140.0)
	last_position    = Vector2(pos_x, pos_y)
	return true

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func update_player_position(pos: Vector2):
	last_position = pos
	save_game()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("game saved, THE VOID AWAITS YOUR ARRAIVAL")
		save_game()
