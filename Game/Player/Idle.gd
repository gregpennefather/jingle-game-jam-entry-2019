extends State

onready var attack := get_parent()

func unhandled_input(event: InputEvent) -> void:
	attack.unhandled_input(event)

func physics_process(delta: float) -> void:
	return

func enter(msg: Dictionary = {}) -> void:
	attack.enter(msg)

func exit() -> void:
	get_parent().exit()
