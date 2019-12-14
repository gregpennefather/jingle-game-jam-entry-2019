extends State

export var acceleration_x: = 5000.0

onready var move:= get_parent()

func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)

func physics_process(delta: float) -> void:
	move.physics_process(delta)
	print('air: %s' %owner.is_on_ground())
	
	if owner.is_on_ground():
		print('move_direction: %s' %move.get_move_direction())
		if move.get_move_direction().x == 0:
			_state_machine.transition_to("Move/Idle")
		else:
			_state_machine.transition_to("Move/Run")
			
		

func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	move.acceleration.x = acceleration_x
	
	if "velocity" in msg:
		move.velocity = msg.velocity
		move.max_speed.x = max(abs(msg.velocity.x), move.max_speed.x)
	if "impulse" in msg:
		print('impulse')
		move.velocity += calculate_jump_velocity(msg.impulse)
		print('move.velocity %s' %move.velocity)

func exit() -> void:
	move.acceleration.x = move.acceleration_default.x
	get_parent().exit()
	
func calculate_jump_velocity(impulse := 0.0) -> Vector2:
	return move.calculate_velocity(
		move.velocity,
		move.max_speed,
		Vector2(0, impulse),
		1.0,
		Vector2.UP
	)
