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
	input_frame(delta)

func _input(event):
	input_event(event)

var touch_input_origin = null
var touch_drag_vector = Vector2(0, 0)

func input_event(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			# touch start
			touch_input_origin = event.position
		else:
			# touch end
			touch_input_origin = null
			touch_drag_vector = Vector2(0, 0)
	if event is InputEventScreenDrag:
		touch_drag_vector = (event.position - touch_input_origin).normalized()

func input_frame(delta):
	var input = Vector3(0, 0, 0)
	input.y += touch_drag_vector.x;
	input.x += touch_drag_vector.y;
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
