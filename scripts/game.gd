# This is the main container for the game
class_name Game
extends Node2D

var paper_scene: PackedScene = preload("res://Scenes/paper.tscn")
@export var puppy_scene: PackedScene # Serializing field for puppers

var paper_stack: Array[Paper] = []

var puppies_in_use: Array[int] = []

# Number of additional papers to dynamically spawn
var spawn_count: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i: int in range(0, spawn_count):
		var index: int = get_unique_puppy()
		if index < 0:
			break
		create_puppy(index)
		create_paper(index)

func create_puppy(index: int) -> void:
	var puppy: Puppy = puppy_scene.instantiate()
	puppy.index = index

	# Choose a random location on Path2D
	var puppy_spawn_location = $PuppyPath/PuppySpawnLocation
	puppy_spawn_location.progress_ratio = randf()

	# Set the puppy's direction perpendicular to the path direction
	var direction = puppy_spawn_location.rotation + PI / 2

	# Set the puppy's position to a random location
	puppy.position = puppy_spawn_location.position

	# Add some randomness to the direction
	direction += randf_range(-PI / 4, PI / 4)
	puppy.rotation = direction

	# Choose the velocity for the puppy TODO: They run offscreen
	#var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	#puppy.linear_velocity = velocity.rotated(direction)

	add_child(puppy)
	add_puppy(puppy)

func create_paper(index: int) -> void:
	var paper: Paper = paper_scene.instantiate()
	paper.index = index

	# Set paper position
	var paper_spawn_location = $PaperPath/PaperSpawnLocation
	paper_spawn_location.progress_ratio = randf()

	paper.position = paper_spawn_location.position

	add_child(paper)
	add_paper(paper)

# Get indices for unique puppies
# -1 returned if no more unique puppies available
func get_unique_puppy() -> int:
	var index: int
	if puppies_in_use.size() == Puppies.Database.size():
		print("All puppies in use!")
		return -1
	while index == null || puppies_in_use.has(index):
		index = randi() % Puppies.Database.size()
	puppies_in_use.append(index)
	return index

func add_paper(paper: Paper) -> void:
	paper_stack.append(paper)
	var count: int = 0
	for p: Paper in paper_stack:
		p.z_index = count
		count += 1

func add_puppy(puppy: Puppy) -> void:
	print("Adding puppy: ", puppy)

func push_paper_to_top(paper: Paper) -> void:
	paper_stack.erase(paper)
	add_paper(paper)
