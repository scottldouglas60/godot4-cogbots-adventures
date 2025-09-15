extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#SignalManager.on_test.connect(test)
	print("Hud Ready")


func test():
	print("signal test connected")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
	#
	#if Input.is_anything_pressed():
		#print("Anything pressed")
		#GameManager.load_next_level()


func _on_high_score_pressed():
	print("High Score Pressed")
	GameManager.load_level_score()


func _on_settings_pressed():
	print("Settings Pressed")
	GameManager.load_level_settings()

func _on_start_pressed():
	print("Start  Pressed")
	GameManager.load_level_1()
