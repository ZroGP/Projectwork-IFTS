# CharacterSelect.gd
extends Control

var selected_character := ""

@onready var female_btn = $VBoxContainer/female
@onready var male_btn   = $VBoxContainer/male
@onready var name_input = $VBoxContainer/player_name
@onready var start_btn  = $VBoxContainer/start

func _ready():
	start_btn.disabled = true
	female_btn.pressed.connect(_select.bind("res://scenes/characters/female-character.tscn", female_btn, male_btn))
	male_btn.pressed.connect(_select.bind("res://scenes/characters/male-character.tscn", male_btn, female_btn))
	name_input.text_changed.connect(func(_t): _refresh())
	start_btn.pressed.connect(_on_start)

func _select(char_scene: String, chosen: Button, other: Button):
	selected_character = char_scene
	chosen.modulate = Color.WHITE
	other.modulate  = Color(1, 1, 1, 0.4)
	_refresh()

func _refresh():
	start_btn.disabled = selected_character.is_empty() or name_input.text.strip_edges().is_empty()

func _on_start():
	globals.player_name      = name_input.text.strip_edges()
	globals.player_character = selected_character
	globals.last_scene       = "res://scenes/main/game.tscn"
	globals.save_game()
	get_tree().change_scene_to_file("res://scenes/main/game.tscn")
