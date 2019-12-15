extends Node2D

func _ready():
	Events.connect("player_gave_up_item", self, '_on_player_gave_up_item')	
	Events.connect("player_took_back_item", self, '_on_player_took_back_item')	
	
	if not PlayerStats.SaveSelfOnlyPath:
		$SaveYourselfLabel.text = "Give others your gear to save them!"

func _on_player_gave_up_item(item_name):
	print(item_name)
	if item_name == "Armour":
		PlayerStats.Armour = false
	if item_name == "Sword":
		PlayerStats.Sword = false
	if item_name == "Boots":
		PlayerStats.Boots = false
	if item_name == "WimpKey":
		PlayerStats.Keys -= 1
		PlayerStats.WimpSaved = true
	if item_name == "RogueKey":
		PlayerStats.Keys -= 1
		PlayerStats.RogueSaved = true
	if item_name == "OldManKey":
		PlayerStats.Keys -= 1
		PlayerStats.OldManSaved = true
	if item_name == "RingOfResurrection":
		PlayerStats.ResurrectionRing = false
		
	PlayerStats.emit_signal("player_items_changed")

func _on_player_took_back_item(item_name):
	print(item_name)
	if item_name == "Armour":
		PlayerStats.Armour = true
	if item_name == "Sword":
		PlayerStats.Sword = true
	if item_name == "Boots":
		PlayerStats.Boots = true
	if item_name == "WimpKey":
		PlayerStats.Keys += 1
		PlayerStats.WimpSaved = false
	if item_name == "RogueKey":
		PlayerStats.Keys += 1
		PlayerStats.RogueSaved = false
	if item_name == "OldManKey":
		PlayerStats.Keys += 1
		PlayerStats.OldManSaved = false
	if item_name == "RingOfResurrection":
		PlayerStats.ResurrectionRing = true
	PlayerStats.emit_signal("player_items_changed")

func _on_ExitDoor_body_entered(body):
	if body is Player:
		get_tree().change_scene("res://Scenes/DungeonScene.tscn")
