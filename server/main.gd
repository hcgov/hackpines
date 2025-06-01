extends Control

var port: int = 4150
var network: ENetMultiplayerPeer = ENetMultiplayerPeer.new()

var peers: Dictionary = {}

func log_(msg: String) -> void:
	print("[Server] [%s] %s" % [Time.get_datetime_string_from_system(), msg])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	log_("Server is starting")
	
	var status: int = network.create_server(port)
	
	match status:
		OK:
			multiplayer.multiplayer_peer = network
			log_("Started server on port %s" % port)
		ERR_ALREADY_IN_USE:
			log_("Failed to bind to port %s" % port)
		ERR_CANT_CREATE:
			log_("Unable to create server :(")
	
	network.peer_connected.connect(_peer_connected)
	network.peer_disconnected.connect(_peer_disconnected)

func _peer_connected(id: int) -> void:
	log_("Peer %s connected" % id)
	peers[id] = {}
	
	var scene: CharacterBody2D = load("res://scenes/player.tscn").instantiate()
	scene.set_multiplayer_authority(id)
	scene.name = str(id)
	scene.get_node("Username").text = str(id)
	
	$MultiplayerSpawner.add_child(scene)

func _peer_disconnected(id: int) -> void:
	log_("Peer %s disconnected" % id)
	peers.erase(id)
