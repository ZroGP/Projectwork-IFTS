extends Area2D

# This signal tells game.gd to pause the global spawner
signal mess_cleaned 

var _home: Vector2
var _is_active: bool = false

func _ready() -> void:
	_home = position
	visible = false
	_is_active = false
	$CollisionPolygon2D.set_deferred("disabled", true)

func on_interact(_player) -> void:
	_hide_mess()

func show_mess() -> void:
	position = _home
	visible = true
	_is_active = true
	$CollisionPolygon2D.set_deferred("disabled", false)

func _hide_mess() -> void:
	visible = false
	_is_active = false
	$CollisionPolygon2D.set_deferred("disabled", true)
	# Emit the signal to trigger the breather delay in game.gd
	mess_cleaned.emit()
