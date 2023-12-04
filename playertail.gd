extends Area3D

@export var color: Color = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready():
	var material = StandardMaterial3D.new()
	material.albedo_color = color
	$MeshInstance3D.material_override = material


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
