extends TextureRect

signal joystick_start #emit signal when player first touch the joystick
signal joystick_end #emit it when it release it 
signal joystick_updated #emit it everytime its position is changed
 #where the Joystick_Ring can move
@export var radius: float = 50.0
#if true the joystick works only in a specific region of the screen
@export var use_screen_rectangle: bool = false 
@export var screen_rectangle: Rect2 = Rect2() 
 
#the direction and intensity of the joystick
var joystick_vector: Vector2 = Vector2.ZERO 
#when false it means the joystick isnt being used
var joystick_active: bool = false 

# These are assigned when the node enters the scene tree
# The @onready makes sure child nodes exist before we try to access them
@onready var joystick_ring: Control = $Joyscitk_Ring
 
func _ready() -> void:
	# Check if we're running in the editor or the actual game
	# Engine.is_editor_hint() returns true when viewing in Godot editor
	if not Engine.is_editor_hint():
		#center the position at the start of the game
		reset_joystick_position()
		visible = not use_screen_rectangle 

func reset_joystick_position() -> void:
	# Centers the joystick ring in the middle of the background texture
	# size = size of this TextureRect (the joystick background)
	# joystick_ring.size = size of the movable ring graphic
	joystick_ring.position = (size / 2) - (joystick_ring.size / 2)
	joystick_vector = Vector2.ZERO

#this is where it blocks the input to the joystick when ui is open
func _input(event: InputEvent) -> void:
	if globals.is_ui_active: 
		return
	
	# Check for touch or mouse clicks
	if event is InputEventScreenTouch or event is InputEventMouseButton: 
		#var to get the position
		var event_pos = get_local_mouse_position()
		var center = size / 2
		
		if event.pressed: 
			if center.distance_to(event_pos) <= radius: 
				#it activates only when you press the joystick radius and nothing else
				joystick_active = true 
				update_joystick(event_pos)
				joystick_start.emit() #emit signal to other scripts
		else:#this when you release the joystick
			if joystick_active: 
				joystick_active = false 
				reset_joystick_position()
				joystick_end.emit() 
		
	# Check for dragging
	if (event is InputEventScreenDrag or event is InputEventMouseMotion) and joystick_active: 
		update_joystick(get_local_mouse_position())
func update_joystick(local_pos: Vector2) -> void:
	var center = size / 2
	var dist = center.distance_to(local_pos)
	
 
	# stays inside the background instead of the center.
	var clamped_radius = radius - (joystick_ring.size.x / 2)
	
	if dist <= clamped_radius: 
		# Move freely within the inner circle
		joystick_ring.position = local_pos - (joystick_ring.size / 2) 
		joystick_vector = (local_pos - center) / clamped_radius 
	else:
		# Stay stuck to the inner edge
		joystick_vector = (local_pos - center).normalized() 
		joystick_ring.position = center + (joystick_vector * clamped_radius) - (joystick_ring.size / 2) 
	#emit signal for other scripts like female_character.gd
	joystick_updated.emit()
