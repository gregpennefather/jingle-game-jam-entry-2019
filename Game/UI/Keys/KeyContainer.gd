extends MarginContainer

export (PackedScene) var key_scene

var max_keys: int setget set_max_keys

func set_max_keys(value: int):
	max_keys = value
	for child in $HBoxContainer.get_children():
		child.queue_free()
	for index in range(max_keys):
		$HBoxContainer.add_child(key_scene.instance())
		

func set_available_keys(keys: int):
	var count := 0
	for child_index in range(max_keys):
		if child_index >= (max_keys - keys):
			$HBoxContainer.get_child(child_index).modulate = Color(1,1,1,1)
		else:
			$HBoxContainer.get_child(child_index).modulate = Color(0,0,0,0)
