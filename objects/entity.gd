class_name Entity extends DungeonObject

@export var max_health: int = 10
var current_health: int = 10

var grid_direction: Vector2i = Vector2i.DOWN

func _ready() -> void:
	current_health = max_health



## 移動先を指定して移動する
func move(target_position: Vector2i) -> void:
	grid_position = target_position


## ダメージを受ける
func take_damage(amount: int) -> void:
	if amount <= 0:
		return
	current_health = max(current_health - amount, 0)

## 生存しているか
func is_alive() -> bool:
	return current_health > 0
