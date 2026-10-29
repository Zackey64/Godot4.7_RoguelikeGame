class_name Enemy extends Entity

@export var enemy_data: EnemyData

# ================================================================

func _ready() -> void:
	max_health = enemy_data.max_health
	current_health = max_health

## 攻撃が可能か
func can_attack(target: Entity, dungeon_map: DungeonMap) -> bool:
	for attack_pattern in enemy_data.attack_patterns:
		if attack_pattern.can_attack_target(dungeon_map, self, target):
			return true
	return false

## 移動行動が可能か
func can_move(dungeon_map: DungeonMap) -> bool:
	# 移動可能かを判定
	return true
