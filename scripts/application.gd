# This is a piece of paper with details that may match a db entry/puppy sprite
class_name Application
extends CharacterBody2D

const DRAG_SPEED: Vector2 = Vector2(30, 30)

var draggingDistance: float
var direction: Vector2
var dragging: bool
var newPosition: Vector2 = Vector2()

var mouse_in: bool = false
var is_selected: bool = false

# Labels
@onready var message: Label = $Message
@onready var puppy_name: Label = $Details/Name
@onready var puppy_color: Label = $Details/Color
@onready var puppy_size: Label = $Details/Size
@onready var puppy_energy: Label = $Details/Energy
@onready var puppy_is_capitalist: Label = $Details/IsCapitalist

# Details text
var name_text: String = "Name: %s"
var color_text: String = "Color: %s"
var size_text: String = "Size: %s"
var energy_text: String = "Energy: %s"
var is_capitalist_text: String = "Is Capitalist: %s"

# Must be set before use. TODO: Get the _init method working with constructor argument
var index: int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Determine Details text
	var puppy_specs: Dictionary = Puppies.Database[index]
	message.text = "Puppy Available"
	puppy_name.text = name_text % puppy_specs["name"]
	puppy_color.text = color_text % puppy_specs["color"]
	puppy_size.text = size_text % puppy_specs["size"]
	puppy_energy.text = energy_text % puppy_specs["energy"]
	puppy_is_capitalist.text = is_capitalist_text % puppy_specs["is_capitalist"]

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if is_selected and event.is_pressed() && mouse_in:
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
