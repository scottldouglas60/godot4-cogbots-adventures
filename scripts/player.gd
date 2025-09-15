# player.gd


extends CharacterBody2D

class_name Player

enum PlayerState{IDLE, RUN, JUMP, FALL, HURT}

const GRAVITY: float = 690.0
const JUMP_SPEED: float = -300.0
const HURT_JUMP_VELOCITY : Vector2 = Vector2(0,-130.0)
const RUN_SPEED: float = 120.0
var playerSpeed: float = 0.0

@onready var sprite_2d = $Sprite2D
@export var bullet_speed: float = 600.0

var direction: Vector2 = Vector2.RIGHT  # Default facing direction
var can_shoot: bool = true
var shoot_cooldown: float = 0.2  # Time between shots in seconds
var lives : int = 5



# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_player_hit.connect
	SignalManager.on_game_over.connect


		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()
	
	#velocity.x = RUN_SPEED
	
	if is_on_floor() and GameManager.playerJump == 1:
		velocity.y = JUMP_SPEED
		GameManager.playerJump = 0
		
	##if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		##velocity.y = JUMP_SPEED
		
	#velocity.x = RUN_SPEED * Input.get_axis("ui_left","ui_right")
	if GameManager.playerDirection == GameManager.LEFT:
		velocity.x = -RUN_SPEED
		sprite_2d.flip_h = true
		direction = Vector2.LEFT
	#if Input.is_action_pressed("left") == true:
		#velocity.x = -RUN_SPEED
		#sprite_2d.flip_h = true
	if GameManager.playerDirection == GameManager.RIGHT:
		velocity.x = RUN_SPEED
		sprite_2d.flip_h = false	
		direction = Vector2.RIGHT
		
	if GameManager.playerDirection == GameManager.STOP:
		velocity.x = 0
		
	#elif Input.is_action_pressed("ui_right") == true:
		#velocity.x = RUN_SPEED
		#sprite_2d.flip_h = false
	
	# Handle shooting
	#if Input.is_action_pressed("shoot") and can_shoot:
		#shoot()
	
	

#func shoot() -> void:
	## Start cooldown(space between bullets)
	#can_shoot = false
	#await get_tree().create_timer(shoot_cooldown).timeout
	#can_shoot = true


func _on_hit_box_area_entered(area):
	print(" Player hit box activated")
	var area_name: String = area.name
	print("Area entered: ", area_name)
	
	
	# NOTE the child Area2D of the AnimatedSprite2D must be in the group Hazard
	# not the parent Animatedsprite2d
	
	if area.is_in_group("hazards"):
		lives -= 1
		SignalManager.on_player_hit.emit(lives)
		print(" in group hazards decremeting lives")

	
		if lives <= 0:
			print("Player Game Over")
			SignalManager.on_game_over.emit()
			set_physics_process(false)
	
	
	
