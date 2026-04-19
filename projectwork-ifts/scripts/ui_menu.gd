extends Control

# Settings
@onready var menu_container = %PopupMenu 
@onready var settings_button = %Settings
@onready var exit_button = %Settings_Exit
# Credits
@onready var credits_button = %Button_Credits      
@onready var credits_popup = %Pop_Credits 
@onready var exit_credits = %Exit_Credits      
# Languages
@onready var languages_button = %Button_Languages   
@onready var languages_popup = %Pop_Language 
@onready var exit_languages = %Exit_Language  
# Quit
@onready var quit_button = %Quit  
@onready var quit_popup = %Pop_Quit 
@onready var no_quit = %No 
@onready var yes_quit = %Yes
# Account
@onready var account_button = %Button_Account  
@onready var account_popup = %Pop_Account
@onready var exit_account = %Exit_Account
@onready var account_delete = %Account_Del
# Delete
@onready var popup_del = %Popup_Del
@onready var del_yes = %Del_yes
@onready var del_no = %Del_no
# Shop
@onready var shop_button = %Button_Shop
@onready var popup_shop = %Popup_Shop

# Gameplay UI
var joystick_female = null
var joystick_male = null
@onready var interact = %interact

var coin_count_label: Label = null
var account_coin_label: Label = null
var account_name_label: Label = null

func _ready():
	menu_container.hide()
	exit_button.pressed.connect(_on_exit_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	
	exit_credits.pressed.connect(_on_exit_credits_pressed)
	credits_popup.hide()
	
	languages_button.pressed.connect(_on_languages_button_pressed)
	exit_languages.pressed.connect(_on_exit_languages_pressed)
	languages_popup.hide()
	
	quit_button.pressed.connect(_on_quit_button_pressed)
	no_quit.pressed.connect(_on_no_quit_pressed)
	yes_quit.pressed.connect(_on_yes_quit_pressed)
	quit_popup.hide()
	
	account_button.pressed.connect(_on_account_button_pressed)
	exit_account.pressed.connect(_on_exit_account_pressed)
	account_delete.pressed.connect(_on_account_delete_pressed)
	account_popup.hide()
	
	del_yes.pressed.connect(_on_del_yes_pressed)
	del_no.pressed.connect(_on_del_no_pressed)
	popup_del.hide()
	
	shop_button.pressed.connect(_on_shop_button_pressed)
	popup_shop.hide()

	call_deferred("_find_joysticks")
	call_deferred("_find_coin_labels")

func _find_joysticks():
	var root = get_tree().root
	var female_joystick_path = "room/CanvasLayer/ui_menu_female/Control_Joystick/JoystickFemale"
	joystick_female = root.get_node_or_null(female_joystick_path)
	var male_joystick_path = "room/CanvasLayer/ui_menu_male/Control_Joystick/JoystickMale"
	joystick_male = root.get_node_or_null(male_joystick_path)

func _find_coin_labels():
	var root = get_tree().root
	var female_coin = root.get_node_or_null("room/CanvasLayer/ui_menu_female/Female_Shop_Home/V_Shop_Home/H_Shop_Home/NinePatchRect/Coin_Count")
	var male_coin = root.get_node_or_null("room/CanvasLayer/ui_menu_male/Male_Shop_Home/V_Shop_Home/H_Shop_Home/NinePatchRect/Coin_Count")
	
	if female_coin and female_coin.is_visible_in_tree():
		coin_count_label = female_coin
	elif male_coin and male_coin.is_visible_in_tree():
		coin_count_label = male_coin
	
	account_coin_label = get_node_or_null("%Account_Coin_Count")
	account_name_label = get_node_or_null("%Account_Name")

func _set_gameplay_active(active: bool):
	globals.is_ui_active = !active
	
	if globals.player_character.contains("female"):
		if joystick_female:
			joystick_female.visible = active
	else:
		if joystick_male:
			joystick_male.visible = active
	
	if interact:
		interact.visible = active
		if interact is Button or interact is TextureButton:
			interact.disabled = !active

func _on_settings_button_pressed():
	_set_gameplay_active(false)
	popup_shop.hide()
	credits_popup.hide()
	languages_popup.hide()
	quit_popup.hide()
	account_popup.hide()
	menu_container.show()

func _on_exit_button_pressed():
	menu_container.hide()
	_set_gameplay_active(true)
	
func _on_credits_button_pressed():
	menu_container.hide()
	credits_popup.show()
	
func _on_exit_credits_pressed():
	credits_popup.hide()
	menu_container.show()
	
func _on_languages_button_pressed():
	menu_container.hide()
	languages_popup.show()
	
func _on_exit_languages_pressed():
	languages_popup.hide()
	menu_container.show()
	
func _on_quit_button_pressed():
	menu_container.hide()
	quit_popup.show()
	
func _on_no_quit_pressed():
	quit_popup.hide()
	menu_container.show()
	
func _on_yes_quit_pressed():
	globals.save_game()
	get_tree().quit()
	
func _on_account_button_pressed():
	menu_container.hide()
	account_popup.show()
	
func _on_account_delete_pressed():
	account_popup.hide()
	popup_del.show()

func _on_del_no_pressed():
	popup_del.hide()
	account_popup.show()
	
func _on_del_yes_pressed():
	DirAccess.remove_absolute(globals.SAVE_PATH)
	get_tree().quit()
	
func _on_exit_account_pressed():
	account_popup.hide()
	menu_container.show()

func _on_shop_button_pressed():
	if popup_shop.visible:
		popup_shop.hide()
		_set_gameplay_active(true)
	else:
		_set_gameplay_active(false)
		popup_shop.show()
		credits_popup.hide()
		languages_popup.hide()
		quit_popup.hide()
		account_popup.hide()
		menu_container.hide()

func _process(_delta: float) -> void:
	var coin_label = globals.get_meta("coin_label", null)
	if coin_label:
		coin_label.text = str(globals.coins)
	
	var account_coin = get_node_or_null("%Account_Coin_Count")
	if account_coin:
		account_coin.text = str(globals.coins)
	
	var account_name = get_node_or_null("%Account_Name")
	if account_name:
		account_name.text = str(globals.player_name)
