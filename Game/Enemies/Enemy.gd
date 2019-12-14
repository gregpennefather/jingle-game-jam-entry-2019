extends KinematicBody2D
class_name Enemy
const FLOOR_NORMAL := Vector2.UP

export (float) var SPEED = 5000

var alive: bool = true
var velocity = Vector2(-SPEED, 10)
var gravity := 100

onready var animation_player := get_node("AnimationPlayer")

func _ready() -> void:
	Events.connect("enemy_hit", self, "_on_hit_by_player")
	
func _physics_process(delta):
	if alive:
		if is_on_wall() or not $FloorAheadRay.is_colliding():
			change_facing()
		velocity.y = move_and_slide(velocity * delta, FLOOR_NORMAL).y
	
func change_facing() -> void:
	velocity.x *= -1
	scale.x *= -1

static func _on_hit_by_player(enemy) -> void:
	enemy.alive = false
	enemy.animation_player.play("die")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "die":
		call_deferred("queue_free")


func _on_CollisionArea_body_entered(body):
	if body.has_method('_on_Player_hit'):
		print('collision')
		Events.emit_signal("player_hit", body)
