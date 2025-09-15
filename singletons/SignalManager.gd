#SignalManager.gd
extends Node

#signal on_boss_killed
#signal on_level_complete(complete: bool)
signal on_player_hit
signal on_player_shoot
signal on_player_jump
signal on_lever_blue_l
signal on_score_updated
signal on_game_over


#signal on_create_bullet(
	#pos: Vector2, dir: Vector2, speed: float, 
	#ob_type: Constants.ObjectType
#)

#signal on_create_object(
	#pos: Vector2, ob_type: Constants.ObjectType
#)

#func emit_on_level_complete(complete: bool) -> void:
	#on_level_complete.emit(complete)

#func emit_on_player_hit(lives: int, shake: bool) -> void:
	#on_player_hit.emit(lives, shake)


#func emit_on_boss_killed() -> void:
	#on_boss_killed.emit()


#func emit_on_create_bullet(pos: Vector2, dir: Vector2, speed: float, 
	#ob_type: Constants.ObjectType) -> void:
	#on_create_bullet.emit(pos, dir, speed, ob_type)


#func emit_on_create_object(pos: Vector2, ob_type: Constants.ObjectType) -> void:
	#on_create_object.emit(pos, ob_type)


#func emit_on_scored(points: int) -> void:
	#on_scored.emit(points)
