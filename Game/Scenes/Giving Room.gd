extends Node2D

func _ready():
	PlayerStats.Sword = $Player/Items/Sword.active
	PlayerStats.Boots = $Player/Items/Boots.active
	PlayerStats.Armour = $Player/Items/Armour.active
	PlayerStats.Keys = $Player/Items/Keys.DEFAULT_NUMBER_OF_KEYS
	Events.connect("player_gave_up_item", self, '_on_player_gave_up_item')	

func _on_player_gave_up_item(item_name):
	if item_name == "Armour":
		PlayerStats.Armour = false
		PlayerStats.emit_signal("player_items_changed")


func _on_ExitDoor_body_entered(body):
	if body is Player:
		get_tree().change_scene("res://Scenes/DungeonScene.tscn")
