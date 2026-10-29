class_name TurnManager extends Node



var is_processing_turn: bool = false


## Playerの行動終了後に呼び出す
func execute_turn() -> void:
	if is_processing_turn:
		return
	is_processing_turn = true
	await execute_enemy_attacks() # 1. 敵の攻撃
	await execute_enemy_movements() # 2. 敵の移動
	await execute_stage_gimmicks() # 3. ステージギミック
	is_processing_turn = false


func execute_enemy_attacks() -> void:
	pass

func execute_enemy_movements() -> void:
	pass

func execute_stage_gimmicks() -> void:
	pass
