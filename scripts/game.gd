# This is the main container for the game
class_name Game
extends Node2D

var paper_scene: PackedScene = preload("res://Scenes/paper.tscn")
var application_scene: PackedScene = preload("res://scenes/application.tscn")
@export var puppy_scene: PackedScene # Serializing field for puppers

var paper_stack: Array[Node2D] = []

var puppies_in_use: Array[int] = []

# Number of additional papers to dynamically spawn
var spawn_count: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Dialogue.hide()
	
	for i: int in range(0, spawn_count):
		var index: int = get_unique_puppy()
		if index < 0:
			break
		create_puppy(index)
		create_paper(index)

func create_puppy(index: int) -> void:
	var puppy: Puppy = puppy_scene.instantiate()
	puppy.index = index

	add_child(puppy)

func create_paper(index: int) -> void:
	var paper: Node2D = paper_scene.instantiate()
	paper.index = index

	var x = randi() % 200 + 400
	var y = randi() % 200 + 650

	paper.position = Vector2(x, y)

	add_child(paper)
	stack_paper(paper)

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

func stack_paper(paper: Node2D) -> void:
	paper_stack.append(paper)
	var count: int = 0
	for p: Node2D in paper_stack:
		p.z_index = count
		count += 1

func push_paper_to_top(paper: Node2D) -> void:
	paper_stack.erase(paper)
	stack_paper(paper)

func continue_dialogue() -> void:
	$Dialogue.show()
	var message: String = $Human.get_dialogue_text()
	if message.length() > 0:
		$Dialogue.show_message(message)
	else:
		$Dialogue.hide()

func _on_human_give_application():
	var application: Application = application_scene.instantiate()
	application.position = Vector2(384, 306)

	add_child(application)

func _on_setup_timer_timeout():
	$Human.speed = 200
	$DialogueTimer.start()

func _on_dialogue_timer_timeout():
	$Human.speed = 0
	continue_dialogue()
