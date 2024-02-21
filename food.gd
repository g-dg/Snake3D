class_name Food
extends Area3D

@export var color: Color

@onready var MeshInstance: MeshInstance3D = $MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	((MeshInstance.mesh as BoxMesh).material as StandardMaterial3D).albedo_color = Color(color, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
