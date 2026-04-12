extends HSlider

# This allows you to list multiple bus names in the Inspector 
@export var target_buses: Array[String] = ["MusicNormal", "MusicStress"]

func _ready() -> void: 
	value_changed.connect(_on_value_changed)
	
	# Initialize slider position based on the first bus in the list
	if target_buses.size() > 0:
		var first_idx = AudioServer.get_bus_index(target_buses[0])
		if first_idx != -1:
			value = db_to_linear(AudioServer.get_bus_volume_db(first_idx))
	
func _on_value_changed(new_value: float) -> void:
	var db_volume = linear_to_db(new_value)
	
	# Loop through every bus in your list and apply the same volume 
	for b_name in target_buses:
		var bus_index = AudioServer.get_bus_index(b_name)
		if bus_index != -1:
			AudioServer.set_bus_volume_db(bus_index, db_volume)
	
	
	
	
