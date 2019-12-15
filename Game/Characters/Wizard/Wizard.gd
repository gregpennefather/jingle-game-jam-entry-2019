extends Character

func save():
	.save()
	Events.emit_signal("player_gave_up_item", 'RingOfResurrection')

func take_back():
	.take_back()
	Events.emit_signal("player_took_back_item", 'RingOfResurrection')
