extends Area3D

@export var movement_speed = 10
@export var rotate_speed = PI / 2

signal food_eaten
signal hit_tail

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_input(delta)

func process_input(delta):
	var input = Vector3(0, 0, 0)
	if Input.is_action_pressed("up"):
		input.x -= 1
	if Input.is_action_pressed("down"):
		input.x += 1
	if Input.is_action_pressed("left"):
		input.y -= 1
	if Input.is_action_pressed("right"):
		input.y += 1
	if Input.is_action_pressed("rotate_left"):
		input.z -= 1
	if Input.is_action_pressed("rotate_right"):
		input.z += 1
	input = input.normalized();
	rotate_object_local(Vector3.UP, -input.y * rotate_speed * delta)
	rotate_object_local(Vector3.RIGHT, -input.x * rotate_speed * delta)
	rotate_object_local(Vector3.BACK, -input.z * rotate_speed * delta)
	transform = transform.orthonormalized()
	position += -transform.basis.z.normalized() * movement_speed * delta

func _on_area_entered(area):
	if area.is_in_group("food"):
		food_eaten.emit(area.color)
		area.queue_free()
	if area.is_in_group("playertail"):
		hit_tail.emit()
