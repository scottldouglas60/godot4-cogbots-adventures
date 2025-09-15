#player_cam.gd

extends Camera2D

@export var shake_amount: float = 5
@onready var shake_timer = $ShakeTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	# Dont start _process util we are we are ready
	set_process(false)
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_game_over.connect(on_game_over)

func on_player_hit(_lives: int):
	set_process(true)
	shake_timer.start()	

func reset_camera():
	set_process(false) # stops the _process(delta)
	offset= Vector2.ZERO
	
func on_game_over():
	reset_camera()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset = get_random_offset()	

func get_random_offset():
	return Vector2(
		randf_range(-shake_amount, shake_amount),
		randf_range(-shake_amount, shake_amount)		
		)
	
func _on_shake_timer_timeout():
	set_process(false) # stops the _process(delta)
	offset= Vector2.ZERO
