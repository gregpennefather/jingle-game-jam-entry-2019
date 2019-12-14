tool
extends Area2D

export (bool) var is_open = true setget set_is_open

onready var keys_item_reference: Node = get_node(keys_item_reference_path)

export var keys_item_reference_path: NodePath

func _ready():
	print(is_open)
	update_display()

func set_is_open(value: bool) -> void:
	is_open = value
	update_display()

func update_display():
	if has_node("DoorClosed") and has_node("DoorOpen"):
		if is_open:
			$DoorClosed.hide()
			$DoorOpen.show()
			$StaticBody2D.set_collision_layer_bit(1, false)
		else:
			$DoorClosed.show()
			$DoorOpen.hide()
			$StaticBody2D.set_collision_layer_bit(1, true)

func _on_Door_body_entered(body):
	if body is Player and not is_open:
		print('player body')
		if keys_item_reference.use_key():
			self.is_open = true
		
