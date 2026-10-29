class_name DungeonMap extends Node2D

enum TileType {
	WALL,
	FLOOR,
}

@export var map_width: int = 50
@export var map_height: int = 50

@onready var ground_layer: TileMapLayer = $Ground
@onready var wall_layer: TileMapLayer = $Wall

var tiles: Array[Array] = []

# 0 = 壁、1 = 床
var map_data: Array[String] = [
	"################",
	"#......#########",
	"#..##....#######",
	"#......#########",
	"################",
]

# TileSet内のタイルの配置情報
const SOURCE_ID: int = 0
const FLOOR_ATLAS := Vector2i(2, 2)
const WALL_ATLAS := Vector2i(6, 3)


func _ready() -> void:
	generate_map()


func generate_map() -> void:
	ground_layer.clear()
	wall_layer.clear()

	for y in range(map_data.size()):
		for x in range(map_data[y].length()):
			var cell := Vector2i(x, y)
			var tile := map_data[y][x]

			if tile == ".":
				ground_layer.set_cell(
					cell,
					SOURCE_ID,
					FLOOR_ATLAS
				)
			elif tile == "#":
				wall_layer.set_cell(
					cell,
					SOURCE_ID,
					WALL_ATLAS
				)

## エンティティを登録
func add_entity(entity: Entity) -> void:
	if not entities.has(entity):
		entities.append(entity)

## エンティティを登録解除
func remove_entity(entity: Entity) -> void:
	entities.erase(entity)



func is_wall(position)-> bool:
	return false
