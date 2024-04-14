class_name Stamp
extends CharacterBody2D

const DRAG_SPEED: Vector2 = Vector2(30, 0)

var draggingDistance: float
var direction: Vector2
var dragging: bool
var newPosition: Vector2 = Vector2()

var mouse_in: bool = false
var is_selected: bool = false

var is_open: bool = false
var left_bound: int = 550
var right_bound: int = 950

signal puppy_stamp
signal no_puppy_stamp

var locked: bool = true

func _input(event: InputEvent) -> void:
	if locked:
		newPosition.x = right_bound
		is_open = false
		return

	if event is InputEventMouseButton:
		if is_selected && event.is_pressed() && mouse_in:
			dragging = true

			if is_open:
				newPosition.x = right_bound
				is_open = false
			else:
				newPosition.x = left_bound
				is_open = true
		else:
			dragging = false

func _physics_process(_delta: float) -> void:
	if dragging || (locked && position.x != right_bound):
		set_velocity((newPosition - position) * DRAG_SPEED)
		move_and_slide()

func select() -> void:
	is_selected = true

func _on_mouse_entered() -> void:
	mouse_in = true

func _on_mouse_exited() -> void:
	mouse_in = false

func _on_puppy_button_pressed():
	locked = true
	puppy_stamp.emit()

func _on_no_puppy_button_pressed():
	locked = true
	no_puppy_stamp.emit()