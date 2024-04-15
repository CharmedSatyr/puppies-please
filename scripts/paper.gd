# This is a piece of paper with details matching a db entry/puppy sprite
class_name Paper
extends DraggablePaper

var photo_page: bool = true

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


func _on_page_corner_pressed():
	photo_page = !photo_page
	if photo_page:
		$ImageHeader.show()
		$Image.show()
	else:
		$ImageHeader.hide()
		$Image.hide()
