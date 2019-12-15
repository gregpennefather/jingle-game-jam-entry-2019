extends Character

export (String) var key_holder_name

func save():
	.save()
	Events.emit_signal("player_gave_up_item", key_holder_name)

func take_back():
	.take_back()
	Events.emit_signal("player_took_back_item", key_holder_name)
