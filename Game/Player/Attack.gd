extends State

onready var item_reference: Node = get_node(item_reference_path)

export var item_reference_path: NodePath

var can_attack : bool setget ,get_can_attack

func get_can_attack() -> bool:
	return item_reference.active

func _get_configuration_warning() -> String:
	if not item_reference_path.is_empty():
		return ""
	else:
		return "Item Reference Path should not be empty."

func unhandled_input(event: InputEvent) -> void:
	pass
