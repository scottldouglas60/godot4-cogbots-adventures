# Drone.gd

extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var drone = $"."
@onready var col_idle = $Area2D/CollisionShape2DIdle
@onready var col_jump = $Area2D/CollisionShape2DJump
@onready var anim = $AnimationPlayer
@onready var idle_timer = $Idle
@onready var patrol_timer = $Patrol
@onready var state_label = $Sprite2D/LabelDroneState
@onready var label_patrol_timer = $Sprite2D/LabelPatrolTimer
@onready var label_patrol_direction = $Sprite2D/LabelPatrolDirection

#@onready var animation_tree = $AnimationTree
##@onready var state_machine = animation_tree["parameters/playback"]


enum DroneState {IDLE, JUMP, EXPLOSION, SHOOT, WALK, ROLL, LOOKOUT, PATROL}

const STATE_NAMES = {
	DroneState.IDLE: "IDLE",
	DroneState.JUMP: "JUMP",
	DroneState.EXPLOSION: "EXPLOSION",
	DroneState.SHOOT: "SHOOT",
	DroneState.WALK: "WALK",
	DroneState.ROLL: "ROLL",
	DroneState.LOOKOUT: "LOOKOUT",
	DroneState.PATROL: "PATROL"
}


const GRAVITY: float = 690.0
var walk_speed = 10.0
var drone_state: DroneState = DroneState.LOOKOUT
var target_seen: bool = false
var target: Node = null  # Reference to the sprite to move toward
var speed: float = 50.0  # Movement speed (pixels per second)
var patrol_direction = Vector2.RIGHT




# Called when the node enters the scene tree for the first time.
func _ready():
	print("Drone Ready")
	col_idle.disabled = false
	col_jump.hide()
	col_idle.show()
	#state_machine.traverse("idle")
	
	anim.speed_scale = 100.0
	anim.play("idle")

	drone_state = DroneState.LOOKOUT
	state_label.text = STATE_NAMES.get(drone_state, "UNKNOWN")
	patrol_timer.start()
	#print("Current drone state: ", STATE_NAMES.get(drone_state, "UNKNOWN"))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	if target_seen:
		# Get direction to the target
		var direction = (target.global_position - global_position).normalized()
		# Move toward the target by updating position
		position += direction * speed * delta
	
	if drone_state == DroneState.PATROL:
		position += patrol_direction * walk_speed * delta
		
	label_patrol_timer.text = str(patrol_timer.time_left)	
	
	if is_on_floor() and GameManager.droneLanded == false:
		GameManager.droneLanded = true
		SignalManager.on_drone_landed.emit()
	
	move_and_slide()

func _on_area_2d_area_exited(_body : Node):
	#_body means unused parameter
	print("Entered")
	#anim.stop()
	#anim.play("lookout")
	drone_state = DroneState.LOOKOUT	
	target_seen = false
	target = null
	state_label.text = STATE_NAMES.get(drone_state, "UNKNOWN")
	
	#idle_timer.start()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "jump": #and is_on_floor():
		drone_state = DroneState.ROLL	
		state_label.text = STATE_NAMES.get(drone_state, "UNKNOWN")	
		

	if target.global_position > global_position:
		anim.play("roll_r")
		
	if target.global_position < global_position:
		anim.play("roll_l")
		
func _on_idle_timeout():
	drone_state = DroneState.LOOKOUT
	state_label.text = STATE_NAMES.get(drone_state, "UNKNOWN")
	anim.play("lookout")

func _on_patrol_timeout():
	# Initially start patrolling after a given time.
	# Once patrolling, reset timer to patrol in the opposite direction
	drone_state = DroneState.PATROL
	state_label.text = STATE_NAMES.get(drone_state, "UNKNOWN")
	anim.play("walk")
	
	if patrol_direction == Vector2.RIGHT:
		patrol_direction = Vector2.LEFT
		label_patrol_direction.text = str(patrol_direction) 
	else:
		patrol_direction = Vector2.RIGHT
		label_patrol_direction.text = str(patrol_direction) 

func _on_area_2d_area_entered(body: Node):
	print("Entered body is", body )
	target_seen = true
	target = body # assign player (area) to target
	print("Player global position is ", target.global_position )
	drone_state = DroneState.JUMP
	state_label.text = STATE_NAMES.get(drone_state, "UNKNOWN")
	anim.speed_scale = 2.0
	anim.play("jump")
	col_idle.disabled = true
	col_idle.hide()
	col_jump.show()
	col_jump.disabled = false
	
