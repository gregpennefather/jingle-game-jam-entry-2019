extends Character

var has_sword : bool setget set_has_sword

func set_has_sword(value: bool) -> void:
	has_sword = value
	if has_node("Body/SwordSprite"):
		if has_sword:
			$Body/SwordSprite.show()
		else:
			$Body/SwordSprite.hide()

func save():
	.save()
	print('dwarf saved')
	self.has_sword = true
	Events.emit_signal("player_gave_up_item", "Sword")


func take_back():
	.take_back()
	self.has_sword = false
	Events.emit_signal("player_took_back_item", "Sword")
