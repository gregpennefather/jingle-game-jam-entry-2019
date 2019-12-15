extends Node2D
class_name Character

export (bool) var requesting := true

var player_in_range : bool = false
var is_saved : bool = false

func play_victory():
	$AnimationPlayer.play("victory")

func _on_Area2D_body_entered(body):
	if body is Player and requesting:
		player_in_range = true
		if is_saved:
			$ThankYouLabel.show()
		else:
			$Label.show()
			$GiveButton.show()


func _on_Area2D_body_exited(body):
	if body is Player and requesting:
		player_in_range = false
		$Label.hide()
		$GiveButton.hide()
		$ThankYouLabel.hide()
		
func _input(event):
	if event.is_action_pressed("give") and player_in_range and not is_saved:
		save()

func save():
	is_saved = true	
	$Label.hide()
	$GiveButton.hide()
	$ThankYouLabel.show()
