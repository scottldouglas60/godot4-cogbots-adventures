#Door1.gd

extends AnimatedSprite2D

@onready var timer = $Timer
@onready var collision_shape_2d = $StaticBody2D/CollisionShape2D
@onready var door_1 = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_lever_blue_l.connect(openDoor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func openDoor():
	print("Door opened")
	collision_shape_2d.set_deferred("disabled",true)
	door_1.play("open")
	timer.start()
	print("Collision after openeing is ",collision_shape_2d.disabled)
	
func _on_area_2d_area_entered(area):
	print("Door 1 entered")

func _on_timer_timeout():
	collision_shape_2d.set_deferred("disabled",false)
	door_1.play("close")
	print("Door closed")
	print("Collision on timeout is ",collision_shape_2d.disabled)
	
