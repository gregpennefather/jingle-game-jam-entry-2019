extends KinematicBody2D
class_name Player

onready var state_machine: StateMachine = $StateMachine
onready var collider: CollisionShape2D = $CollisionShape2D
onready var body := $Body

const FLOOR_NORMAL := Vector2.UP

func _ready():
	Events.connect("player_moved", self, "_on_Player_moved")
	Events.connect("player_attacked", self, "_on_Player_attacked")
	update_body()

func update_body():
	$Body.HasSword = $Items/Sword.active
	$Body.Armoured = $Items/Armour.active

func is_on_ground() -> bool:
	return $FloorDetectorLeft.is_colliding() or $FloorDetectorCenter.is_colliding() or $FloorDetectorRight.is_colliding()

static func _on_Player_moved(player: Player, direction: Vector2) -> void:
	player.body.Facing = sign(direction.x)
	player.body.play_run_animation()
	
static func _on_Player_attacked(player: Player) -> void:
	player.body.play_attack_animation()
