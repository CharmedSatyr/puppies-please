class_name Paper
extends CharacterBody2D

var draggingDistance: float
var dir: Vector2
var dragging: bool
var newPosition: Vector2 = Vector2()

var mouse_in: bool = false
var is_selected: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if is_selected and event.is_pressed() && mouse_in:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging = false
			is_selected = false

	elif event is InputEventMouseMotion:
		if dragging:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir

func _physics_process(_delta: float) -> void:
	if dragging:
		# TODO: what are these numbers 30, 30?
		set_velocity((newPosition - position) * Vector2(30, 30))
		move_and_slide()

func select() -> void:
	is_selected = true
	
func _on_mouse_entered() -> void:
	mouse_in = true

func _on_mouse_exited() -> void:
	mouse_in = false
