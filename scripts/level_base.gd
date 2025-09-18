extends Node2D

@onready var bullet = $Bullet/Bullet
@export var bullet_scene: PackedScene  # Assign Bullet.tscn in inspector of LevelBase
@onready var player = $Player



func _ready():
	SignalManager.on_player_shoot.connect(spawn_bullet)

func spawn_bullet():
	bullet = bullet_scene.instantiate()
	bullet.position = player.position
	bullet.direction = player.direction
	print("Player Direction ", player.direction)
	#bullet.tilemap_layer = tile_map_layer  # Pass TileMapLayer reference
	add_child(bullet)
