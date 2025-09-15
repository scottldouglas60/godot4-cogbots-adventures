extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#get_tree().paused = true
	#show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_exit_pressed():
	get_tree().quit()



func _on_button_return_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	hide()
