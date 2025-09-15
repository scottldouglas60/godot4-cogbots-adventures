extends AnimatedSprite2D
@onready var lever = $"."


func _ready():
	SignalManager.on_lever_blue_l.connect 



func _on_area_2d_area_entered(area):
	print("LeverBlueL actuated")
	lever.play("default")
	SignalManager.on_lever_blue_l.emit()
