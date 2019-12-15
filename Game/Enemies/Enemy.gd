extends KinematicBody2D
class_name Enemy
const FLOOR_NORMAL := Vector2.UP

var velocity := Vector2()
var gravity := 5000
export (int) var damage_to_player = 1

var alive: bool = true

onready var animation_player := get_node("AnimationPlayer")
onready var despawn_timer := get_node("DespawnTimer")

func _ready() -> void:
	set_physics_process(false)
	Events.connect("enemy_hit", self, "_on_hit_by_player")
	
func change_facing() -> void:
	velocity.x *= -1
	scale.x *= -1
	
func face_direction(direction: Vector2) -> void:
	if sign(direction.x) == -1:
		scale.x = abs(scale.x) 
	else:
		scale.x = abs(scale.x) * -1
		

static func _on_hit_by_player(enemy) -> void:
	enemy.alive = false
	enemy.animation_player.play("die")
	enemy.despawn_timer.start()

func _on_CollisionArea_body_entered(body):
	if body.has_method('_on_Player_hit') and alive:
		print('collision')
		Events.emit_signal("player_hit", body, damage_to_player)

func _on_DespawnTimer_timeout():
	call_deferred("queue_free")
