extends State

func _ready() -> void:
	Events.connect("player_attack_ended", self, "_on_player_attack_ended")
	
func _on_player_attack_ended() -> void:
	if _state_machine.state == self:
		_state_machine.transition_to("Attack/Idle")
