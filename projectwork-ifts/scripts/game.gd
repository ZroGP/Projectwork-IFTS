extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
var tempo_gioco = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tempo_gioco == false:
		$Timer.start()
		tempo_gioco = true 


func _on_timer_timeout() -> void:
	var random = randi_range(0,6)
	var oggetti = [$floor_mess1,$floor_mess2,$floor_mess3,$floor_mess4,$floor_mess5,$floor_mess6,$floor_mess7]
	oggetti[random].position.x = globals.array_x[random]
	oggetti[random].position.y = globals.array_y[random]
	globals.array_check[random] = true
	
