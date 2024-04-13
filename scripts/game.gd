class_name Game
extends Node2D

var paper_scene: PackedScene = preload("res://Scenes/paper.tscn")
var paper_stack: Array[Paper] = []

var puppies_in_use: Array[int] = []

# Number of additional papers to dynamically spawn
var spawn_count: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i: int in range(0, spawn_count):
		var paper: Paper = paper_scene.instantiate()
		var index: int = get_unique_puppy()
		if index < 0:
			break

		paper.index = index

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

func push_paper_to_top(paper: Paper) -> void:
	paper_stack.erase(paper)
	add_paper(paper)
