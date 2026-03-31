extends TouchScreenButton
func _ready() -> void:
	pressed.connect(_on_pressed)
	
	

func _on_pressed() -> void:
	var player := _get_player()
	if player:
		player.interact()

func _get_player() -> CharacterBody2D:
	return get_tree().get_first_node_in_group("player") as CharacterBody2D
