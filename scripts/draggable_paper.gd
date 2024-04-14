class_name DraggablePaper
extends CharacterBody2D

const DRAG_SPEED: Vector2 = Vector2(30, 30)

var draggingDistance: float
var direction: Vector2
var dragging: bool
var newPosition: Vector2 = Vector2()

var mouse_in: bool = false
var is_selected: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:

		if is_selected && event.is_pressed() && mouse_in:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			direction = (get_viewport().get_mouse_position() - position).normalized()
			dragging = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * direction
		else:
			dragging = false
			is_selected = false

	elif event is InputEventMouseMotion:
		if dragging:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * direction

func _physics_process(_delta: float) -> void:
	if dragging:
		set_velocity((newPosition - position) * DRAG_SPEED)
		move_and_slide()

func select() -> void:
	is_selected = true

func _on_mouse_entered() -> void:
	mouse_in = true

func _on_mouse_exited() -> void:
	mouse_in = false
