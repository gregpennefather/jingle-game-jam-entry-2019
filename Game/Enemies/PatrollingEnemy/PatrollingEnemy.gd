extends Enemy
export (float) var SPEED = 5000

func _ready():
	._ready()
	velocity = Vector2(-SPEED, 100)
	var groups = get_groups()
	for group in groups:
		if not group.begins_with('root'):
			print('activating group %s' %group)
			for enemy in get_tree().get_nodes_in_group(group):
				print('activating %s' %enemy.name)
				enemy.set_physics_process(true)

func _physics_process(delta):
	if alive:
		velocity.y += gravity
		if is_on_wall() or not $FloorAheadRay.is_colliding():
			change_facing()
		velocity.y = move_and_slide(velocity * delta, FLOOR_NORMAL).y
