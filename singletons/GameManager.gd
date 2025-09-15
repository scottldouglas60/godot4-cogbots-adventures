#GameManager.gd
extends Node


#const MAIN = preload("res://Scenes/Main/Main.tscn")
#const LEVEL_BASE = preload("res://Scenes/LevelBase/LevelBase.tscn")

const STOP = 0
const RIGHT = 1
const LEFT = 2
const SCROLL_SPEED = 100




# Levers and doors variables
@onready var leverBlueL: bool = false
@onready var door1Open: bool = false

# Player variables
@onready var playerDirection = 0
@onready var playerJump = 0



# Game variables
@onready var gameOver: bool = false # game over means player has died


const Levels: Array[PackedScene] = [
	#preload("res://Scenes/LevelBase/Level1.tscn"),
	#preload("res://Scenes/LevelBase/Level2.tscn")
]

# Scores and lives
const SCORES_PATH = "user://high_scores.tres"
@onready var score = 0
@onready var lives = 5

#var high_scores: HighScores = HighScores.new()
var _current_level: int = -1

# score to carry over between levels
var cached_score: int:
	set (value):
		cached_score = value
	get:
		return cached_score

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_Q):
		get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_high_scores()
	print("Game manager ready")

func _exit_tree():
	save_high_scores()

func load_main():
	cached_score = 0
	_current_level = -1
	#get_tree().change_scene_to_packed(MAIN)


func load_next_level():
	_current_level += 1
	if _current_level >= Levels.size():
		_current_level = 0
	get_tree().change_scene_to_packed(Levels[_current_level])


func load_high_scores():		
	if ResourceLoader.exists(SCORES_PATH):
		pass
		#high_scores = load(SCORES_PATH)


func save_high_scores():
	pass
	#ResourceSaver.save(high_scores, SCORES_PATH)
