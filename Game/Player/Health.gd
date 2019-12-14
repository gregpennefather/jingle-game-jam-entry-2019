extends Node

export (int) var base_player_health = 1

onready var item_reference: Node = get_node(item_reference_path)
onready var heart_container: Node = get_node(heart_container_reference_path)

export var item_reference_path: NodePath
export var heart_container_reference_path: NodePath

var player_max_health: int
var player_current_health: int

func _ready():
	player_max_health = base_player_health 
	if item_reference.active:
		player_max_health += item_reference.health_bonus
	player_current_health = player_max_health
	heart_container.set_max_health(player_max_health)
	print('max: %s, cur: %s' %[player_max_health, player_current_health])

func _get_configuration_warning() -> String:
	if not item_reference_path.is_empty():
		return ""
	else:
		return "Item Reference Path should not be empty."
		
func take_damage(amount: int) -> void:
	player_current_health -= amount
	heart_container.set_current_health(player_current_health)
	if player_current_health <= 0:
		Events.emit_signal("player_died", get_parent())
