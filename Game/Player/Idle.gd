extends State

onready var attack := get_parent()

func unhandled_input(event: InputEvent) -> void:
	if attack.can_attack and event.is_action_pressed("attack"): 
		Events.emit_signal("player_attacked", owner)
		_state_machine.transition_to("Attack/Swing")

func physics_process(delta: float) -> void:
	return

func enter(msg: Dictionary = {}) -> void:
	attack.enter(msg)

func exit() -> void:
	get_parent().exit()
