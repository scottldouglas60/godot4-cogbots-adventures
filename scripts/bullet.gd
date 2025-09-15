extends Area2D

@export var speed: float = 300.0  # Bullet speed in pixels per second
var direction: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Move bullet
	position += direction * speed * delta
	
func _on_area_entered(_area):
	queue_free()
