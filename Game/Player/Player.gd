extends KinematicBody2D
class_name Player

onready var state_machine: StateMachine = $StateMachine
onready var collider: CollisionShape2D = $CollisionShape2D
onready var body := $Body
onready var health := $Health
onready var camera_rig := $CameraRig
onready var attack_state_machine := $AttackStateMachine
onready var move := $StateMachine/Move

const FLOOR_NORMAL := Vector2.UP

func _ready():
	Events.connect("player_moved", self, "_on_Player_moved")
	Events.connect("player_attacked", self, "_on_Player_attacked")
	Events.connect("player_hit", self, "_on_Player_hit")
	Events.connect("player_died", self, "_on_Player_died")
	PlayerStats.connect("player_items_changed", self, '_on_player_items_changed')
	update_body()
	
func _on_player_items_changed():
	$Items/Sword.active = PlayerStats.Sword
	$Body.HasSword = $Items/Sword.active
	$Items/Boots.active = PlayerStats.Boots
	$Items/Armour.active = PlayerStats.Armour
	$Body.Armoured = $Items/Armour.active
	$Items/Keys.DEFAULT_NUMBER_OF_KEYS = PlayerStats.Keys
	$Health.update_max_health()

func update_body():
	$Body.HasSword = $Items/Sword.active
	$Body.Armoured = $Items/Armour.active

func is_on_ground() -> bool:
	return $FloorDetectorLeft.is_colliding() or $FloorDetectorCenter.is_colliding() or $FloorDetectorRight.is_colliding()

static func _on_Player_moved(player: Player, direction: Vector2) -> void:
	if player.attack_state_machine.state.name == "Idle":
		player.body.Facing = sign(direction.x)
	player.body.play_run_animation()
	
static func _on_Player_attacked(player: Player) -> void:
	player.body.play_attack_animation()

static func _on_Player_hit(player: Player, damage := 1) -> void:
	if player.state_machine._state_name != "Die":
		player.body.play_hit_animation()
		print(damage)
		player.health.take_damage(damage)

static func _on_Player_died(player: Player) -> void:
	player.state_machine.transition_to("Die", { Velocity = player.move.velocity })
