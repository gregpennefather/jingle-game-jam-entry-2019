extends Character

var is_armoured : bool setget set_is_armoured

func set_is_armoured(value: bool) -> void:
	is_armoured = value
	if has_node("ArmouredSprite"):
		if is_armoured:
			$Sprite.region_rect = Rect2(240, 225, 16, 31)
			$Sprite.position.y = -16
		else:
			$Sprite.region_rect = Rect2(176, 224, 16, 16)

func save():
	.save()
	print('knight saved')
	self.is_armoured = true
	Events.emit_signal("player_gave_up_item", "Armour")
