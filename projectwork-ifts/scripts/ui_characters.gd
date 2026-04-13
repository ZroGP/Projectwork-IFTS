extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame.
func _process(_delta: float) -> void:
	$Label.text = str(globals.coins)
