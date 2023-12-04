extends Area3D

@export var color: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	$MeshInstance3D.mesh.material.albedo_color = Color(color, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
