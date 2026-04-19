extends CharacterBody2D 

@export var detection_area: Area2D 
var joystick: Control = null 
const SPEED: float = 33.0 

# Vector2 is specific for 2d games, its the equivalent of x,y
var direction: Vector2 = Vector2.ZERO 
var last_direction: Vector2 = Vector2.DOWN  #Store facing direction (default down)
var nearby_interactables: Array[Node2D] = [] 
var is_interacting: bool = false 
# Link the InteractionArea signals so the character knows when it's near a mess
func _ready() -> void:
	if has_node("InteractionArea"):
		$InteractionArea.area_entered.connect(_on_interactable_entered)
		$InteractionArea.area_exited.connect(_on_interactable_exited)

func _physics_process(_delta: float) -> void:
	if globals.is_ui_active or is_interacting: 
		#is for the charaters to stop moving when you release the joystick
		velocity = Vector2.ZERO
		move_and_slide()
		return
		#this is needed for the Vector2, where direction is the x,y 
	velocity = direction * SPEED 
	move_and_slide() 
	
	# Store the last non-zero direction for interaction facing
	if direction != Vector2.ZERO:
		last_direction = direction
	
	_animate() 
# Interaction Logic 
func _on_interactable_entered(area: Area2D) -> void:
	if area.is_in_group("interactable") or area.has_method("on_interact"): 
		if not nearby_interactables.has(area):
			nearby_interactables.append(area)

func _on_interactable_exited(area: Area2D) -> void:
	nearby_interactables.erase(area) 

func interact() -> void:
	if nearby_interactables.is_empty() or is_interacting: 
		return
		
	var closest: Node2D = _get_closest(nearby_interactables) 
	if not closest: return

	is_interacting = true 
	
	# Use the direction the player is already facing (not the vector to the mess)
	_face_direction(last_direction)
	# Wait for the animation to finish BEFORE cleaning the mess
	await $AnimatedSprite2D.animation_finished 
	# Trigger the cleanup and coins only AFTER animation is done
	if closest.has_method("on_interact"):
		closest.on_interact(self)
		#Clean up state
	is_interacting = false 
	$AnimatedSprite2D.play(&"idle_down")
#this is needed so the charater faces the mess when interacting with it
func _face_direction(dir: Vector2) -> void:
	$AnimatedSprite2D.flip_h = dir.x < 0.0 
	var angle := dir.angle() 
	var sector := int(round(angle / (PI / 4.0))) % 8
	if sector < 0: sector += 8
	
	match sector: #these is the values the characters follow to face the mess, ex if x < y it will trigger the anim
		0, 4: $AnimatedSprite2D.play(&"interact_side") 
		1, 3: $AnimatedSprite2D.play(&"interact_vertical_down") 
		2:    $AnimatedSprite2D.play(&"interact_down") 
		5, 7: $AnimatedSprite2D.play(&"interact_vertical_up") 
		6:    $AnimatedSprite2D.play(&"interact_up") 

func _get_closest(objects: Array[Node2D]) -> Node2D:
	var best: Node2D = null
	var best_dist := INF
	for obj in objects:
		if is_instance_valid(obj) and obj.visible:
			var d := global_position.distance_squared_to(obj.global_position)
			if d < best_dist:
				best = obj
				best_dist = d
	return best

# Animation based on last action
func _animate() -> void:
	if direction == Vector2.ZERO: 
		var current := $AnimatedSprite2D.animation as String 
		if current.begins_with("walk_"): 
			var idle_anim: StringName
			match current: 
				"walk_side":      idle_anim = &"idle_side"
				"walk_side_down": idle_anim = &"idle_vertical_down"
				"walk_down":      idle_anim = &"idle_down"
				"walk_side_up":   idle_anim = &"idle_vertical_up"
				"walk_up":        idle_anim = &"idle_up"
			$AnimatedSprite2D.play(idle_anim) 
		return
		
	$AnimatedSprite2D.flip_h = direction.x < 0.0 
	var angle := direction.angle()
	var sector := int(round(angle / (PI / 4.0))) % 8
	if sector < 0: sector += 8
	var anim: StringName
	match sector:
		0, 4: anim = &"walk_side"          
		1, 3: anim = &"walk_side_down"     
		2:    anim = &"walk_down"          
		5, 7: anim = &"walk_side_up"       
		6:    anim = &"walk_up"            
	$AnimatedSprite2D.play(anim)
