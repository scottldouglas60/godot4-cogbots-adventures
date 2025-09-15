# h_moving_platform

extends AnimatableBody2D

@export var speed : float = 50.0
@onready var marker_2d = $Marker2D


# Tweening
var _start: Vector2
var _end: Vector2
var _time_to_move: float = 0.0
var _tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	_start = global_position
	_end = marker_2d.global_position
	
	var distance : float = _start.distance_to(_end)
	_time_to_move = distance / speed
	set_moving()
	
# Cleeanly exit tree to prevent crashes	
func _exit_tree():
	if _tween:
		_tween.kill

# Tween is created on tree	
func set_moving():
	_tween = get_tree().create_tween()
	_tween.set_loops()
	_tween.tween_property(self,"global_position", _end, _time_to_move)
	_tween.tween_property(self,"global_position", _start, _time_to_move)

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
