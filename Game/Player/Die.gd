extends State

func unhandled_input(event: InputEvent) -> void:
	return

func physics_process(delta: float) -> void:
	return

func enter(msg: Dictionary = {}) -> void:
	owner.camera_rig.is_active = false
	owner.body.play_die()
	owner.body.connect("animation_finished", self, "_on_Player_animation_finished")

func exit() -> void:
	return
	
func _on_Player_animation_finished():
	print('death animation done')
