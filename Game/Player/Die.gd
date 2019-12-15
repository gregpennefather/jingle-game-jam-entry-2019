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
	$RespawnTimer.start()

func exit() -> void:
	return


func _on_RespawnTimer_timeout():
	get_tree().change_scene("res://Scenes/DungeonScene.tscn")
