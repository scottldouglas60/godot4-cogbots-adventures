# Hud.gd

extends Control

@onready var score_label = $MarginContainer/ScoreLabel
@onready var hb_hearts = $MarginContainer/HBHearts
@onready var vb_game_over = $ColorRect/VBGameOver
@onready var color_rect = $ColorRect

var can_continue : bool = false

var hearts: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_score_updated.connect(on_score_updated)
	SignalManager.on_game_over.connect(game_over)
	hearts = hb_hearts.get_children()

func game_over():
	GameManager.gameOver = true
	print("hud Game Over")
	color_rect.show()
	vb_game_over.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_player_hit(lives: int):
	for life in range(hearts.size()):
		hearts[life].visible = lives > life

func on_score_updated():
	GameManager.score = GameManager.score + 1 
	score_label.text = "%05d" % GameManager.score 	
	print(" Score is ", GameManager.score)

func _on_button_left_pressed():
	GameManager.playerDirection = GameManager.LEFT
	print("Left")

func _on_button_left_released():
	GameManager.playerDirection = GameManager.STOP

func _on_button_right_pressed():
	GameManager.playerDirection = GameManager.RIGHT
	print("Right")
	 
func _on_button_right_released():
	GameManager.playerDirection = GameManager.STOP

func _on_button_jump_pressed():
	if GameManager.gameOver == false:
		GameManager.playerJump = 1
		print("Jump")
	if GameManager.gameOver == true:
		get_tree().quit()
		print("Pressed hud fire")
	
	 
func _on_button_fire_pressed():
	
	if GameManager.gameOver == false:
		print("fire")
		SignalManager.on_player_shoot.emit()
	
	if GameManager.gameOver == true:
		get_tree().quit()
		print("Pressed hud fire")
	 
#func _on_button_pause_pressed():
	#get_tree().change_scene_to_file("res://scenes/pause_screen.tscn")
