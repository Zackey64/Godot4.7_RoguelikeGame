class_name AttackPattern extends Resource

## 攻撃タイプ
enum AttackType {
	MELEE,       # 近接攻撃
	RANGE,      # 遠距離攻撃
	TARGET,      # 場所指定攻撃
}
# ================================================================

@export var attack_name: String
@export var damage: int = 5
## 攻撃タイプ
@export var attack_type: AttackType = AttackType.MELEE
## 攻撃射程（遠距離攻撃または場所指定攻撃）
@export_range(1, 20) var attack_range: int = 1 # １で周囲８マス、２で周囲２４マス、３で周囲４８マス

# ================================================================

## 攻撃可能なマスを取得する（内部メソッド）
## 位置、向き、壁、攻撃タイプで攻撃できるマスを配列で全て返す
func get_target_positions(attacker: Entity, dungeon_map: DungeonMap) -> Array[Vector2i]:
	
	var target_positions: Array[Vector2i] = []
	var direction: Vector2i = attacker.grid_direction
	var position: Vector2i = attacker.grid_position
	
	match attack_type:
		
		# 近接攻撃
		AttackType.MELEE:
			var target_position: Vector2i = position + direction
			if not dungeon_map.is_wall(target_position):
				target_positions.append(target_position)
		
		# 遠距離攻撃
		AttackType.RANGE:
			for distance in range(1, attack_range + 1):
				var target_position: Vector2i = position + direction * distance
				if dungeon_map.is_wall(target_position):
					break
				target_positions.append(target_position)
		
		# 指定攻撃
		AttackType.TARGET:
			for width in range(-attack_range, attack_range + 1):
				for height in range(-attack_range, attack_range + 1):
					var target_position: Vector2i = (
						position
						+ Vector2i.RIGHT * width
						+ Vector2i.DOWN * height
					)
					if target_position == position:
						continue
					if not dungeon_map.is_wall(target_position):
						target_positions.append(target_position)
		
	return target_positions



## 指定した相手を攻撃可能か
func can_attack_target(dungeon_map: DungeonMap, attacker: Entity, target: Entity,) -> bool:
	
	var target_positions: Array[Vector2i] = get_target_positions(attacker, dungeon_map)
	
	for target_position in target_positions:
		if target_position == target.grid_position:
			return true
	
	return false



## 攻撃を実行
func execute_attack(enemy: Enemy, target: Entity) -> void:
	print(attack_name)
	target.take_damage(damage)
