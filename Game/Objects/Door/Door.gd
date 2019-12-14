tool
extends StaticBody2D

export (bool) var Open = true setget set_open

func set_open(value: bool) -> void:
	Open = value
	if has_node("DoorClosed") and has_node("DoorOpen"):
		if Open:
			$DoorClosed.hide()
			$DoorOpen.show()
			$CollisionShape2D.disabled = true
		else:
			$DoorClosed.show()
			$DoorOpen.hide()
			$CollisionShape2D.disabled = false
