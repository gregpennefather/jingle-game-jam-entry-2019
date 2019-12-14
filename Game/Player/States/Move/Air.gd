extends State

export var acceleration_x: = 5000.0
export var fall_acceleration = 200.0
export var extended_jump_impulse_factor := 0.75

var jump_active: bool = false
var just_jumped: bool = false
var initial_jump_impulse := 0

onready var move:= get_parent()

func unhandled_input(event: InputEvent) -> void:
	if Input.get_action_strength("jump") == 0 and jump_active:
		exit_jump()
	move.unhandled_input(event)

func physics_process(delta: float) -> void:
	if not owner.is_on_ground() and jump_active:
		move.velocity = move.calculate_velocity(move.velocity, move.max_speed, move.max_jump_speed, move.max_fall_speed, Vector2(0, initial_jump_impulse) * extended_jump_impulse_factor, delta, Vector2.UP)
		
	move.physics_process(delta)
		
	
	if owner.is_on_ground() and not just_jumped:
		print('leaving jump state')
		if move.get_move_direction().x == 0:
			_state_machine.transition_to("Move/Idle")
		else:
			_state_machine.transition_to("Move/Run")

	just_jumped = false

func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	move.acceleration.x = acceleration_x
	
	if "velocity" in msg:
		move.velocity = msg.velocity
		move.max_speed.x = max(abs(msg.velocity.x), move.max_speed.x)
	if "impulse" in msg:
		enter_jump(msg.impulse)

func enter_jump(impulse: float) -> void:
	print('enter jump')
	jump_active = true
	just_jumped = true
	move.acceleration.y = fall_acceleration
	initial_jump_impulse = impulse
	move.velocity += calculate_jump_velocity(impulse)
	$JumpDuration.start()
	
func exit_jump() -> void:
	print('exit jump at %s' %move.velocity)
	move.acceleration.y = move.acceleration_default.y
	$JumpDuration.stop()

func exit() -> void:
	move.acceleration.x = move.acceleration_default.x
	move.acceleration.y = move.acceleration_default.y
	get_parent().exit()
	
func calculate_jump_velocity(impulse := 0.0) -> Vector2:
	return move.calculate_velocity(
		move.velocity,
		move.max_speed,
		move.max_jump_speed,
		move.max_fall_speed,
		Vector2(0, impulse),
		1.0,
		Vector2.UP
	)

func _on_JumpDuration_timeout():
	exit_jump()
