extends TextureProgressBar


func _on_timer_timeout() -> void:
	%Stress.value += 1
	
