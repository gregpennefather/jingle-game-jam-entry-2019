extends Enemy
export (float) var SPEED = 5000

func _ready():
	._ready()
	velocity = Vector2(-SPEED, 100)

func _physics_process(delta):				
	if alive:
		velocity.y += gravity
		if is_on_wall() or not $FloorAheadRay.is_colliding():
			change_facing()
		if $AnimationPlayer.current_animation != "run":
			$AnimationPlayer.play("run")
		velocity.y = move_and_slide(velocity * delta, FLOOR_NORMAL).y


func _on_VisibilityEnabler2D_screen_entered():
	var groups = get_groups()
	for group in groups:
		if not group.begins_with('root'):
			for enemy in get_tree().get_nodes_in_group(group):
				enemy.set_physics_process(true)
