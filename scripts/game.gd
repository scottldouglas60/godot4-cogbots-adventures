#
# Game.gd
#
# Main game script

extends Node2D

@export var bullet_scene: PackedScene  # Assign Bullet.tscn in inspector
@onready var player = $Level1/Player


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_player_shoot.connect(spawn_bullet)

#func _input(event):
	#
	#if GameManager.gameOver == false:
		#if event.is_action_pressed("fire"):
			#SignalManager.on_player_shoot.emit()
			#print("Pressed game fire")
		#
		#if event.is_action_pressed("jump"):
			#print("Pressed game jump")
			#GameManager.playerJump = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
# can probably remove as all functions are passed via sgnals from
# player then HUD
#func _process(delta):
	#pass

		
func spawn_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = player.position
	bullet.direction = player.direction
	print("Player Direction ", player.direction)
	#bullet.tilemap_layer = tile_map_layer  # Pass TileMapLayer reference
	add_child(bullet)
