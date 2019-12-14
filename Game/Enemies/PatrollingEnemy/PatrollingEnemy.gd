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
		velocity.y = move_and_slide(velocity * delta, FLOOR_NORMAL).y
