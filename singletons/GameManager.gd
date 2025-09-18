#GameManager.gd
# Singleton - Loaded at runtime like a global and persistant

extends Node


const INTRO = preload("res://scenes/intro_scene.tscn")
const SCORE = preload("res://scenes/score_scene.tscn")
const SETTINGS = preload("res://scenes/settings_scene.tscn")
const LEVEL_1 = preload("res://scenes/level_1.tscn")


const STOP = 0
const RIGHT = 1
const LEFT = 2
const SCROLL_SPEED = 100

# Levers and doors variables
@onready var leverBlueL: bool = false
@onready var door1Open: bool = false

# Player variables
@onready var playerDirection = STOP
@onready var playerJump = 0

#Drone variables
@onready var droneLanded: bool = false


# Game variables
@onready var gameOver: bool = false # game over means player has died


const Levels: Array[PackedScene] = [
	preload("res://scenes/level_1.tscn")]#,
	#preload("res://Scenes/LevelBase/Level_2.tscn")
#]

# Scores and lives
const SCORES_PATH = "user://high_scores.tres"
@onready var score = 0
@onready var lives = 5

var high_scores: HighScores = HighScores.new()
var current_level: int = 0

# score to carry over between levels
var cached_score: int:
	set (value):
		cached_score = value
	get:
		return cached_score

#func _input(event: InputEvent):
#	if Input.is_key_pressed(KEY_Q):
#		get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	load_high_scores()
	print("Game manager ready")
	#Needs call deferred to allow for all the singletons to completely load
	#get_tree().call_deferred("change_scene_to_packed", INTRO)
	#await get_tree().create_timer(2.5).timeout
	#get_tree().change_scene_to_packed(INTRO)

func _exit_tree():
	save_high_scores()

func load_level_intro():
	pass
	get_tree().change_scene_to_packed(INTRO)

func load_level_score():
	pass
	get_tree().change_scene_to_packed(SCORE)	
	
func load_level_settings():
	pass
	get_tree().change_scene_to_packed(SETTINGS)

func load_level_1():
	pass
	cached_score = 0
	#_current_level = -1
	get_tree().change_scene_to_packed(LEVEL_1)


func load_next_level():
	current_level += 1
	if current_level >= Levels.size():
		current_level = 0
	get_tree().change_scene_to_packed(Levels[current_level])
	print("Gamemanager load next level which is in array position  ", current_level)


func load_high_scores():
	pass		
	if ResourceLoader.exists(SCORES_PATH):
		pass
		high_scores = load(SCORES_PATH)


func save_high_scores():
	pass
	ResourceSaver.save(high_scores, SCORES_PATH)
