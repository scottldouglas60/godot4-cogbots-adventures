extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_score_updated.connect 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	# If player hits the wrench
	SignalManager.on_score_updated.emit()
	queue_free()
