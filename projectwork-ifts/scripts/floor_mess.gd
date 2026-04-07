extends Area2D

#Timer
@export var respawn_time: float = 10.0

var _home: Vector2
var _is_active: bool = false

func _ready() -> void:
	# Use local position, not global_position — always correct at _ready() time
	_home = position
	visible = false
	_is_active = false
	$CollisionPolygon2D.set_deferred("disabled", true)
	print(name, " ready, home=", _home)

func on_interact(_player) -> void:
	_hide_mess()
	get_tree().create_timer(respawn_time).timeout.connect(_respawn)

#Show the "mess" and at console print the message
func show_mess() -> void:
	position = _home
	visible = true
	_is_active = true
	$CollisionPolygon2D.set_deferred("disabled", false)
	print(name, " shown at ", position)

func _hide_mess() -> void:
	visible = false
	_is_active = false
	$CollisionPolygon2D.set_deferred("disabled", true)

func _respawn() -> void:
	print(name, " respawning")
	show_mess()
