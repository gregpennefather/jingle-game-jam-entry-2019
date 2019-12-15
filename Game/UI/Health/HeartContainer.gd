extends MarginContainer

export (PackedScene) var heart_scene

var max_health: int

func set_max_health(value: int):
	max_health = value
	for child in $HBoxContainer.get_children():
		child.queue_free()
	for index in range(max_health):
		$HBoxContainer.add_child(heart_scene.instance())
		

func set_current_health(current_health: int):
	var count := 0
	for child_index in range(max_health):
		if child_index >= (max_health - current_health):
			$HBoxContainer.get_child(child_index).modulate = Color(1,1,1,1)
		else:
			$HBoxContainer.get_child(child_index).modulate = Color("7d4b3232")
