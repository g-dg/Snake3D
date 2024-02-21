class_name PlayerTail
extends Area3D

@export var color: Color = Color.WHITE

@onready var MeshInstance: MeshInstance3D = $MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = color
	MeshInstance.material_override = material


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
