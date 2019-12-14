extends KinematicBody2D
class_name Enemy

var alive: bool = true

onready var animation_player := get_node("AnimationPlayer")

func _ready() -> void:
	Events.connect("enemy_hit", self, "_on_hit_by_player")

static func _on_hit_by_player(enemy) -> void:
	enemy.alive = false
	enemy.animation_player.play("die")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "die":
		call_deferred("queue_free")
