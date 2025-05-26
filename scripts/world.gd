extends Node2D

# TODO: CHANGE
@onready var server_port: int = 4150
@onready var server_host: String = "SERVER.HOST" if OS.has_feature("export") else "localhost"

var network: ENetMultiplayerPeer = ENetMultiplayerPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("[World] Connecting to server %s:%s" % [server_host, server_port])
	
	var status: int = network.create_client(server_host, server_port)
	
	match status:
		OK:
			multiplayer.multiplayer_peer = network
			print("[World] Connected to server, peerID is %s" % multiplayer.get_unique_id())
		_:
			print("[World] Failed to connect to server")
			# TODO: switch to an error screen or sum

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
