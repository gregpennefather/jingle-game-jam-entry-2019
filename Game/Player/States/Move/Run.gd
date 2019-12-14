extends State

onready var move:= get_parent()

func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)

func physics_process(delta: float) -> void:
	if move.early_jump_active:
		_state_machine.transition_to("Move/Air", { jump = true, early_jump = true })
	elif owner.is_on_ground():
		if move.get_move_direction().x == 0.0:
			_state_machine.transition_to("Move/Idle")
		if sign(move.get_move_direction().x) != sign(move.velocity.x):
			move.velocity.x = 0
	else:
		_state_machine.transition_to("Move/Air")
	move.physics_process(delta)
	Events.emit_signal("player_moved", owner, move.get_move_direction())

func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)

func exit() -> void:
	get_parent().exit()
