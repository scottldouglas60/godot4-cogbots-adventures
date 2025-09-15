#Scrollin layer
extends ParallaxLayer

const IMG_W: float = 768.0 
const IMG_H: float = 768.0 


@onready var sprite_2d: Sprite2D = $Sprite2D

@export var  texture : Texture2D
@export var scroll_scale: float= 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	motion_scale.x = scroll_scale
	motion_scale.y = scroll_scale
	
	var scale_f = get_viewport_rect().size.y / IMG_H
	
	sprite_2d.texture = texture
	sprite_2d.scale = Vector2(scale_f,scale_f)
	
	motion_mirroring.x = IMG_W * scale_f
	motion_mirroring.y = IMG_H * scale_f
	
	
