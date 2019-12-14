tool
extends Node2D

export (bool) var Armoured = true setget set_armoured
export (int) var Facing = 1 setget set_facing

func set_armoured(value: bool) -> void:
	Armoured = value
	if has_node("ArmouredSprite") and has_node("UnarmouredSprite"):
		if Armoured:
			$ArmouredSprite.show()
			$UnarmouredSprite.hide()
		else:
			$UnarmouredSprite.show()
			$ArmouredSprite.hide()

func set_facing(value: int) -> void:
	Facing = value
	if sign(Facing) == 1:
		$ArmouredSprite.scale.x = abs($ArmouredSprite.scale.x)
		$UnarmouredSprite.scale.x = abs($UnarmouredSprite.scale.x)
	elif sign(Facing) == -1:
		
		$ArmouredSprite.scale.x = abs($ArmouredSprite.scale.x) * -1
		$UnarmouredSprite.scale.x = abs($UnarmouredSprite.scale.x) * -1
		
func play_animation():
	$AnimationPlayer.play("run")
