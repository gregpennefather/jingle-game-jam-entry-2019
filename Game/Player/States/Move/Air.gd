extends State

export var acceleration_x: = 5000.0
export var fall_acceleration = 200.0
export var extended_jump_impulse_factor := 0.75
export var jump_impulse := 350.0
export var air_jump_impulse := 300.0

var jump_active: bool = false
var just_jumped: bool = false
var holding_last_jump: bool = false
var air_jump_used: bool = false
var can_air_jump: bool

onready var item_reference: Node = get_node(item_reference_path)

export var item_reference_path: NodePath

var early_jump_active : bool setget ,get_early_jump_active

func get_early_jump_active() -> bool:
	return not $EarlyJumpTimer.is_stopped()

onready var move:= get_parent()

func _ready():
	can_air_jump = item_reference.active

func unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_released("jump"):
		holding_last_jump = false
	if not holding_last_jump and jump_active:
		exit_jump()
	if Input.is_action_pressed("jump") and not holding_last_jump:
		if not air_jump_used and can_air_jump:
			enter_jump(air_jump_impulse, true)
		elif not owner.is_on_ground():
			$EarlyJumpTimer.start()
		
	move.unhandled_input(event)

func physics_process(delta: float) -> void:
	if not owner.is_on_ground() and jump_active:
		move.velocity = move.calculate_velocity(move.velocity, move.max_speed, move.max_jump_speed, move.max_fall_speed, Vector2(0, jump_impulse) * extended_jump_impulse_factor, delta, Vector2.UP)
		
	move.physics_process(delta)
	Events.emit_signal("player_moved", owner, move.get_move_direction())
	
	if owner.is_on_ground() and not just_jumped:
		if self.early_jump_active:
			early_jump()
			return
		elif move.get_move_direction().x == 0:
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
	if "early_jump" in msg:
		move.velocity.y = 0
		move.clear_early_jump()
	if "jump" in msg:
		enter_jump(jump_impulse)
		
func early_jump():
	$EarlyJumpTimer.stop()
	move.velocity.y = 0
	enter_jump(jump_impulse)

func enter_jump(impulse: float, is_air_jump := false) -> void:
	jump_active = true
	just_jumped = true
	holding_last_jump = Input.is_action_pressed("jump")
	if is_air_jump:
		move.velocity.y = 0
		if sign(move.get_move_direction().x) != sign(move.velocity.x):
			move.velocity.x = 0
		air_jump_used = true
	move.acceleration.y = fall_acceleration
	move.velocity += calculate_jump_velocity(impulse, is_air_jump)
	$JumpDuration.start()
	
func exit_jump() -> void:
	jump_active = false
	move.acceleration.y = move.acceleration_default.y
	$JumpDuration.stop()

func exit() -> void:
	if jump_active:
		exit_jump()
	air_jump_used = false
	holding_last_jump = false
	move.acceleration.x = move.acceleration_default.x
	move.acceleration.y = move.acceleration_default.y
	get_parent().exit()
	
func calculate_jump_velocity(impulse := 0.0, include_x_acceleration := false) -> Vector2:
	var acceleration = Vector2(0, impulse)
	if include_x_acceleration:
		acceleration.x = move.acceleration.x
	return move.calculate_velocity(
		move.velocity,
		move.max_speed,
		move.max_jump_speed,
		move.max_fall_speed,
		acceleration,
		1.0,
		Vector2.UP
	)

func _on_JumpDuration_timeout():
	exit_jump()

func _get_configuration_warning() -> String:
	if not item_reference_path.is_empty():
		return ""
	else:
		return "Item Reference Path should not be empty."
