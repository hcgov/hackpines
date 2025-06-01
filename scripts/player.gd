extends CharacterBody2D

const SPEED = 50.0

func _ready() -> void:
	set_multiplayer_authority(int(name))
	
	if is_multiplayer_authority():
		RPC.update_player_data.rpc(name)
		$Username.text = name
	else:
		RPC._on_update_player_data.connect(_on_update_player_data)

func _on_update_player_data(username: String) -> void:
	if multiplayer.get_remote_sender_id() == int(name):
		$Username.text = username

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
