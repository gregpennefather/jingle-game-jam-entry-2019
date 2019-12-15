extends State

var velocity: Vector2

func unhandled_input(event: InputEvent) -> void:
	return

func physics_process(delta: float) -> void:
	var move_direction = Vector2.DOWN
	var acceleration = 1200
	velocity += move_direction * acceleration * delta
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)

func enter(msg: Dictionary = {}) -> void:
	if "velocity" in msg:
		velocity = msg.velocity
	owner.camera_rig.is_active = false
	owner.body.play_die()
	owner.body.connect("animation_finished", self, "_on_Player_animation_finished")

func exit() -> void:
	return
	
	
func _on_Player_animation_finished():
	print('death animation done')
