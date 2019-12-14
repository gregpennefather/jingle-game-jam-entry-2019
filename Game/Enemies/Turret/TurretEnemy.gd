extends Enemy

onready var aim_direction := $AimDirection
onready var aim_ray := $AimDirection/AimRay

export (PackedScene) var projectile_scene

var target : Player
var telegraphing_attack := false

func _physics_process(delta):
	if alive and target != null:
		var target_direction = global_position.direction_to(target.global_position)
		face_direction(target_direction)
		if $AttackRechargeTimer.is_stopped() and not telegraphing_attack:
			telegaph_attack()

func telegaph_attack():
	telegraphing_attack = true
	animation_player.play("attack")

func attack_target() -> void:
	print('attacking')
	var projectile = projectile_scene.instance()
	projectile.global_position = $FirePosition.global_position
	get_tree().root.add_child(projectile)
	projectile.start(target)
	$AttackRechargeTimer.start()

func _on_AggroArea_body_entered(body):
	if body is Player:
		target = body

func _on_AggroArea_body_exited(body):
	if body is Player:
		target = body


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		telegraphing_attack = false
		attack_target()
		print('attack anim finished')
