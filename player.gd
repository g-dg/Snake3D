class_name Player
extends Area3D

@export var movement_speed: float = 10.0
@export var rotate_speed: float = PI / 2

signal food_eaten
signal hit_tail

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	input_frame(delta)

func _input(event: InputEvent) -> void:
	input_event(event)

var touch_input_origin: Vector2 = Vector2.ZERO
var touch_drag_vector: Vector2 = Vector2.ZERO

func input_event(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if (event as InputEventScreenTouch).pressed:
			# touch start
			touch_input_origin = (event as InputEventScreenTouch).position
		else:
			# touch end
			touch_input_origin = Vector2.ZERO
			touch_drag_vector = Vector2.ZERO
	if event is InputEventScreenDrag:
		touch_drag_vector = ((event as InputEventScreenDrag).position - touch_input_origin).normalized()

func input_frame(delta: float) -> void:
	var input: Vector3 = Vector3.ZERO
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

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("food"):
		food_eaten.emit((area as Food).color)
		area.queue_free()
	if area.is_in_group("playertail"):
		hit_tail.emit()
