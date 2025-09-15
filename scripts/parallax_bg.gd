# Scrolling_bg

extends ParallaxBackground


func _ready() -> void:
	pass
	
	
func _process(delta):
	scroll_offset.x -= GameManager.SCROLL_SPEED * delta
	
