extends Node2D

func _ready():
	$PlayerBody.Armoured = PlayerStats.Armour
	$PlayerBody.HasSword = PlayerStats.Sword
	$PlayerBody.play_victory()
	if not PlayerStats.Armour:
		$Knight.show()
		$Knight.is_armoured = true
		$Knight.play_victory()
	else:
		$Knight.hide()
