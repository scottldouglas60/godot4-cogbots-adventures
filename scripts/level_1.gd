# level_1.gd
extends Node2D

@onready var door_1 = $Doors/Door1
@onready var lever_blue_l = $Levers/LeverBlueL
@export var bullet_scene: PackedScene  # Assign Bullet.tscn in inspector
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_player_shoot.connect(spawn_bullet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = player.position
	bullet.direction = player.direction
	print("Player Direction ", player.direction)
	#bullet.tilemap_layer = tile_map_layer  # Pass TileMapLayer reference
	add_child(bullet)
