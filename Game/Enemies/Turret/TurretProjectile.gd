extends Area2D

export var speed = 450
export var steer_force = 50.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null

func start(_target):
	target = _target
	velocity = (target.position - position).normalized() * speed

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	face_direction(velocity)
	position += velocity * delta
	
func face_direction(direction: Vector2) -> void:
	if sign(direction.x) == -1:
		scale.x = abs(scale.x) 
	else:
		scale.x = abs(scale.x) * -1
	
func _on_TurretProjectile_body_entered(body):
	if body is Player:
		Events.emit_signal("player_hit", body)
	queue_free()

func _on_DeathTimer_timeout():
	queue_free()
