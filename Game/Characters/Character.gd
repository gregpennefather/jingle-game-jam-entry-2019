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
		if not PlayerStats.SaveSelfOnlyPath:
			if is_saved:
				$ThankYouLabel.show()
				$TakeButton.show()
			else:
				$Label.show()
				$GiveButton.show()
		else:
			$WontSaveUsLabel.show() 


func _on_Area2D_body_exited(body):
	if body is Player and requesting:
		player_in_range = false
		$Label.hide()
		$GiveButton.hide()
		$ThankYouLabel.hide()
		$TakeButton.hide()
		$WontSaveUsLabel.hide() 
		
func _input(event):
	if event.is_action_pressed("give") and player_in_range and not PlayerStats.SaveSelfOnlyPath:
		if not is_saved:
			save()
		else:
			take_back()
		

func save():
	is_saved = true	
	$Label.hide()
	$GiveButton.hide()
	$ThankYouLabel.show()
	$TakeButton.show()

func take_back():
	is_saved = false	
	$Label.show()
	$GiveButton.show()
	$ThankYouLabel.hide()
	$TakeButton.hide()
	
