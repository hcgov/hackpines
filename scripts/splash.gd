extends Control

func _ready() -> void:
	if OS.get_cmdline_args().has("--server") or OS.get_cmdline_user_args().has("--server"):
		get_tree().change_scene_to_file("res://server/main.tscn")
	
	await get_tree().create_timer(1).timeout
	
	get_tree().change_scene_to_file("res://scenes/world.tscn")
