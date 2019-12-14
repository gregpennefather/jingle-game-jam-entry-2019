extends KinematicBody2D
class_name Player

onready var state_machine: StateMachine = $StateMachine
onready var collider: CollisionShape2D = $CollisionShape2D

const FLOOR_NORMAL := Vector2.UP

func is_on_ground() -> bool:
	return $FloorDetector.is_colliding()
