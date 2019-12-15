extends Item

onready var key_container: Node = get_node(key_container_reference_path)

export var key_container_reference_path: NodePath

export (int) var DEFAULT_NUMBER_OF_KEYS := 3

var keys_remaining := DEFAULT_NUMBER_OF_KEYS

func _ready():
	update_max_keys()

func use_key() -> bool:
	if keys_remaining > 0:
		keys_remaining -= 1
		key_container.set_available_keys(keys_remaining)
		return true
	return false

func update_max_keys():
	key_container.max_keys = keys_remaining
