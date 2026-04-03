extends CharacterBody2D
const SPEED: float = 30.0
var direction: Vector2
var nearby_interactables: Array[Node2D] = []
var is_interacting: bool = false

func _ready() -> void:
	$InteractionArea.area_entered.connect(_on_interactable_entered)
	$InteractionArea.area_exited.connect(_on_interactable_exited)

func _on_interactable_entered(area: Area2D) -> void:
	if area.is_in_group("interactable"):
		nearby_interactables.append(area)

func _on_interactable_exited(area: Area2D) -> void:
	nearby_interactables.erase(area)

func interact() -> void:
	if nearby_interactables.is_empty() or is_interacting:
		return
	var closest: Node2D = _get_closest(nearby_interactables)
	nearby_interactables.erase(closest)

	var dir: Vector2 = (closest.global_position - global_position).normalized()
	$AnimatedSprite2D.flip_h = dir.x < 0.0

	var angle := dir.angle()
	var sector := int(round(angle / (PI / 4.0))) % 8
	if sector < 0:
		sector += 8
	var interact_anim: StringName
	match sector:
		0:  interact_anim = &"interact_side"
		1:  interact_anim = &"interact_vertical_down"
		2:  interact_anim = &"interact_down"
		3:  interact_anim = &"interact_vertical_down"
		4:  interact_anim = &"interact_side"
		5:  interact_anim = &"interact_vertical_up"
		6:  interact_anim = &"interact_up"
		7:  interact_anim = &"interact_vertical_up"

	is_interacting = true
	$AnimatedSprite2D.play(interact_anim)
	globals.coins += 1
	print(globals.coins)

	await $AnimatedSprite2D.animation_finished
	is_interacting = false
	$AnimatedSprite2D.play(&"idle_down")
	_animate()

	if closest.has_method("on_interact"):
		closest.on_interact(self)

func _get_closest(objects: Array[Node2D]) -> Node2D:
	var best: Node2D = objects[0]
	var best_dist := global_position.distance_squared_to(best.global_position)
	for obj in objects:
		var d := global_position.distance_squared_to(obj.global_position)
		if d < best_dist:
			best = obj
			best_dist = d
	return best

func _physics_process(_delta: float) -> void:
	if is_interacting:
		return
	direction = Input.get_vector(&"ui_left", &"ui_right", &"ui_up", &"ui_down")
	velocity = SPEED * direction
	move_and_slide()
	_animate()

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
	if sector < 0:
		sector += 8
	var anim: StringName
	match sector:
		0:  anim = &"walk_side"
		1:  anim = &"walk_side_down"
		2:  anim = &"walk_down"
		3:  anim = &"walk_side_down"
		4:  anim = &"walk_side"
		5:  anim = &"walk_side_up"
		6:  anim = &"walk_up"
		7:  anim = &"walk_side_up"
	$AnimatedSprite2D.play(anim)
