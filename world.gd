class_name World
extends Node3D

@export var food_scene: PackedScene
@export var tail_scene: PackedScene

signal score_point
signal game_over
signal left_world
signal reentered_world

@onready var PlayerNode: Player = $Player

var game_size: float = 25
var cube_count: int = int(game_size)
var tail_segments_per_food: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("setup")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func setup() -> void:
	for i in cube_count:
		spawn_food()
	PlayerNode.position += PlayerNode.transform.basis.z.normalized() * game_size
	(($SoftWorldBoundary/CollisionShape3D as CollisionShape3D).shape as BoxShape3D).size = (Vector3(game_size, game_size, game_size) + Vector3.ONE * 10) * 2
	(($HardWorldBoundary/CollisionShape3D as CollisionShape3D).shape as BoxShape3D).size = (Vector3(game_size, game_size, game_size) + Vector3.ONE * 30) * 2


func spawn_food() -> void:
	var food: Food = food_scene.instantiate()
	var color: Color = Color(randf(), randf(), randf())
	food.color = color
	food.position = Vector3(randf_range(-game_size, game_size), randf_range(-game_size, game_size), randf_range(game_size * -1, game_size))
	add_child(food)


func _on_player_food_eaten(color: Color) -> void:
	food_eaten(color)


var tail_scenes: Array[Node] = []
var pending_tail_creations: int = 100
var current_tail_color: Color = Color.WHITE

func food_eaten(color: Color) -> void:
	score_point.emit()
	pending_tail_creations += tail_segments_per_food
	current_tail_color = color
	spawn_food()


func advance_tail() -> void:
	var new_tail: PlayerTail = tail_scene.instantiate()
	new_tail.transform = PlayerNode.transform
	new_tail.position += PlayerNode.transform.basis.z.normalized() * 1.5
	new_tail.color = current_tail_color
	tail_scenes.push_front(new_tail)
	add_child(new_tail)

	if pending_tail_creations > 0:
		pending_tail_creations -= 1
	else:
		var tail_end: Node = tail_scenes.pop_back()
		tail_end.queue_free()


func _on_advance_tail_timer_timeout() -> void:
	advance_tail()


func _on_player_hit_tail() -> void:
	game_over.emit()


func _on_soft_world_boundary_area_exited(area: Area3D) -> void:
	if area.is_in_group("player"):
		left_world.emit()


func _on_soft_world_boundary_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		reentered_world.emit()


func _on_hard_world_boundary_area_exited(area: Area3D) -> void:
	if area.is_in_group("player") and not resetting:
		game_over.emit()


func set_pause(paused: bool) -> void:
	get_tree().paused = paused


var resetting: bool = false

func reset() -> void:
	resetting = true
	get_tree().paused = false
	get_tree().reload_current_scene()
