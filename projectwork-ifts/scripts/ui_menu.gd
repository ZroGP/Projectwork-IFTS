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

# Home/Shop
@onready var shop_button = %Button_Shop
@onready var popup_shop = %Popup_Shop

@onready var home_button = %Button_Home
@onready var popup_home = %Popup_Home

@onready var joystick = %VirtualJoystick
@onready var interact = %interact

func _ready():
	#Settings
	menu_container.hide()
	exit_button.pressed.connect(_on_exit_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	
	#Credits
	credits_button.pressed.connect(_on_credits_button_pressed)
	exit_credits.pressed.connect(_on_exit_credits_pressed)
	credits_popup.hide()
	
	#Langages
	languages_button.pressed.connect(_on_languages_button_pressed)
	exit_languages.pressed.connect(_on_exit_languages_pressed)
	languages_popup.hide()
	
	#Quit
	quit_button.pressed.connect(_on_quit_button_pressed)
	no_quit.pressed.connect(_on_no_quit_pressed)
	yes_quit.pressed.connect(_on_yes_quit_pressed)
	quit_popup.hide()
	
	#Account
	account_button.pressed.connect(_on_account_button_pressed)
	exit_account.pressed.connect(_on_exit_account_pressed)
	
	account_popup.hide()
	
	# SHop/Home
	shop_button.pressed.connect(_on_shop_button_pressed)
	popup_shop.hide()
	
	home_button.pressed.connect(_on_home_button_pressed)
	popup_home.hide()
	
	
	
func _on_settings_button_pressed():
	popup_shop.hide()
	popup_home.hide()
	joystick.hide()
	interact.hide()
	menu_container.show()
	
	
func _on_exit_button_pressed():
	menu_container.hide()
	joystick.show()
	interact.show()
	
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
	
func _on_account_button_pressed():
	menu_container.hide()
	account_popup.show()
	
func _on_yes_quit_pressed():
	get_tree().quit()
	
func _on_exit_account_pressed():
	account_popup.hide()
	menu_container.show()
	
	
	
func _on_shop_button_pressed():
	if popup_shop.visible:
		popup_shop.hide()
		joystick.show()
		interact.show()

	else:
		popup_shop.show()
		credits_popup.hide()
		languages_popup.hide()
		quit_popup.hide()
		account_popup.hide()
		menu_container.hide()
		popup_home.hide()
		joystick.hide()
		interact.hide()
		
		
func _on_home_button_pressed():
	if popup_home.visible:
		popup_home.hide()
		joystick.show()
		interact.show()
	else:
		credits_popup.hide()
		languages_popup.hide()
		quit_popup.hide()
		account_popup.hide()
		joystick.hide()
		interact.hide()
		popup_home.show()
		menu_container.hide()
		popup_shop.hide()
	
	
	
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	%Coin_Count.text = str(globals.coins)
