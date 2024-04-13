class_name Paper
extends CharacterBody2D

const DRAG_SPEED: Vector2 = Vector2(30, 30)

var draggingDistance: float
var direction: Vector2
var dragging: bool
var newPosition: Vector2 = Vector2()

var mouse_in: bool = false
var is_selected: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var name_text = "Name: %s"
	var color_text = "Color: %s"
	var size_text = "Size: %s"
	var energy_text = "Energy: %s"
	var is_capitalist_text = "Is Capitalist: %s"
	
	# Determine Details text
	var puppy_specs = Puppies.Database[randi() % Puppies.Database.size()]
	$Message.text = "Puppy Available"
	$Details/Name.text = name_text % puppy_specs["name"]
	$Details/Color.text = color_text % puppy_specs["color"]
	$Details/Size.text = size_text % puppy_specs["size"]
	$Details/Energy.text = energy_text % puppy_specs["energy"]
	$Details/IsCapitalist.text = is_capitalist_text % puppy_specs["is_capitalist"]

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
