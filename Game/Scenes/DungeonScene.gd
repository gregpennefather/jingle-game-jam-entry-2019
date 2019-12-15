extends Node2D

func _ready():
	$Player._on_player_items_changed()


func _on_ExitDoor_body_entered(body):
	print('entered')
	if body is Player:
		print('player won!')
		get_tree().change_scene("res://Scenes/VictoryScreen.tscn")
