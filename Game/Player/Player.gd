extends KinematicBody2D
class_name Player

onready var state_machine: StateMachine = $StateMachine
onready var collider: CollisionShape2D = $CollisionShape2D
onready var body := $Body

const FLOOR_NORMAL := Vector2.UP

func _ready():
	Events.connect("player_moved", self, "_on_Player_moved")

func is_on_ground() -> bool:
	return $FloorDetectorLeft.is_colliding() or $FloorDetectorCenter.is_colliding() or $FloorDetectorRight.is_colliding()

static func _on_Player_moved(player: Player, direction: Vector2) -> void:
	player.body.Facing = sign(direction.x)
	player.body.play_animation()
