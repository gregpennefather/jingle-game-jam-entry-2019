extends Character

var is_armoured : bool setget set_is_armoured

func set_is_armoured(value: bool) -> void:
	is_armoured = value
	if has_node("Body/Sprite"):
		if is_armoured:
			$Body/Sprite.region_rect = Rect2(240, 225, 16, 31)
			$Body/Sprite.position.y = -16
		else:
			$Body/Sprite.region_rect = Rect2(176, 224, 16, 16)
			$Body/Sprite.position.y = 0

func save():
	.save()
	self.is_armoured = true
	Events.emit_signal("player_gave_up_item", "Armour")

func take_back():
	.take_back()
	self.is_armoured = false
	Events.emit_signal("player_took_back_item", "Armour")
