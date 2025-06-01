extends Node

signal _on_update_player_data(username: String)

# file for RPCs
@rpc("any_peer", "call_remote", "reliable")
func update_player_data(username: String) -> void:
	_on_update_player_data.emit(username)
