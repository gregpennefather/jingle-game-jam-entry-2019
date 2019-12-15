extends Area2D

var used = false

func _on_RespawnZone_body_entered(body):
	if body is Player:
		if PlayerStats.ResurrectionRing and not used:
			PlayerStats.RespawnPosition = $RespawnPoint.get_global_position()
			PlayerStats.KeysUsed = body.keys_used
			used = true
