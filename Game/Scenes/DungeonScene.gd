extends Node2D

func _input(event):
	if event.is_action_pressed("escape"):
		PlayerStats.reset()
		get_tree().change_scene("res://Scenes/Giving Room.tscn")

func _ready():
	$Player.global_position = PlayerStats.RespawnPosition
	$Player._on_player_items_changed()
	if not PlayerStats.Sword:
		$WorldControls/AttackOrDodgeLabel.text = "Dodge!"
	if not PlayerStats.Boots:
		$WorldControls/DoubleJumpLabel.text = "Take the long way!"

func _on_ExitDoor_body_entered(body):
	if body is Player:
		get_tree().change_scene("res://Scenes/VictoryScreen.tscn")


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()
