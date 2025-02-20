tool
extends Node2D

export (bool) var Armoured = true setget set_armoured
export (bool) var HasSword = true setget set_has_sword
export (int) var Facing = 1 setget set_facing

func set_armoured(value: bool) -> void:
	Armoured = value
	if has_node("Frame"):
		if Armoured:
			$Frame/ArmouredSprite.show()
			$Frame/UnarmouredSprite.hide()
		else:
			$Frame/UnarmouredSprite.show()
			$Frame/ArmouredSprite.hide()
			
func set_has_sword(value: bool) -> void:
	HasSword = value
	if has_node("Sword"):
		if not HasSword:
			$Sword.hide()
		else:
			$Sword.show()
	

func set_facing(value: int) -> void:
	Facing = value
	if sign(Facing) == 1:
		scale.x = abs(scale.x)
		scale.x = abs(scale.x)
	elif sign(Facing) == -1:
		scale.x = abs(scale.x) * -1
		scale.x = abs(scale.x) * -1
		
func play_victory():
	$Frame/AnimationPlayer.play("victory")
		
func play_run_animation():
	if $Frame/AnimationPlayer.current_animation == "idle" or $Frame/AnimationPlayer.current_animation == "run"  or $Frame/AnimationPlayer.current_animation == "":
		$Frame/AnimationPlayer.play("run")
	if HasSword:
		if $Sword/AnimationPlayer.current_animation == "run" or $Sword/AnimationPlayer.current_animation == "idle":
			$Sword/AnimationPlayer.play("run")

func play_die():
	$Frame/AnimationPlayer.play("die")
		
func play_hit_animation():
	$Frame/AnimationPlayer.play("hit")
		
func play_attack_animation():
	if HasSword:
		$Sword/AnimationPlayer.play("swing")

func _on_Sword_AnimationPlayer_animation_finished(anim_name) -> void:
	if anim_name == "swing":
		Events.emit_signal("player_attack_ended")
	$Sword/AnimationPlayer.play("idle")

func _on_SwingArea_body_entered(body):
	Events.emit_signal("enemy_hit", body)

func _on_AnimationPlayer_animation_changed(old_name, new_name):
	if old_name == "swing":
		Events.emit_signal("player_attack_ended")
