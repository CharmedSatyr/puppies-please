# This is the main container for the game
class_name Game
extends Node2D

var paper_scene: PackedScene = preload("res://Scenes/paper.tscn")
var application_scene: PackedScene = preload("res://scenes/application.tscn")

@export var puppy_scene: PackedScene # Serializing field for puppers

var paper_stack: Array[Node2D] = []

# Dictionary indices of puppies whose Papers/sprites are instantiated
var puppies_in_use: Array[int] = []
# References to created puppies, by { index: Puppy }
var puppies: Dictionary = {}
# Index of the puppy that has been adopted. Available after approving adoption
var adopted: int
# Currently, you're mishousing the dog if it's not Theo because Theo is brown
# and that's what the human wants
var mishoused_dog: bool

# Number of puppy dossiers to dynamically spawn
var spawn_count: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Dialogue.hide()
	$Introduction.hide()
	$DayOver.hide()
	$TitleScreen.show()
	
	for i: int in range(0, spawn_count):
		var index: int = get_unique_puppy()
		if index < 0:
			break
		create_puppy(index)
		create_paper(index)

func create_puppy(index: int) -> void:
	var puppy: Puppy = puppy_scene.instantiate()
	puppy.index = index
	
	var x = randi() % 200 + 400
	var y = randi() % 200 + 100

	puppy.position = Vector2(x, y)

	add_child(puppy)
	puppies[index] = puppy

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
		if p != null:
			p.z_index = count
			count += 1

func push_paper_to_top(paper: Node2D) -> void:
	paper_stack.erase(paper)
	stack_paper(paper)
	# Keep stamp on top
	stack_paper($Stamp)

func continue_dialogue() -> void:
	$Dialogue.show()
	var message: String = $Human.get_dialogue_text()

	if message == $Human.END_DIALOGUE:
		$Dialogue.hide()
		cleanup_human()
	elif message.length() > 0:
		$Dialogue.show_message(message)
		$Stamp.enabled = false
	else:
		$Stamp.enabled = true
		$Dialogue.hide()

func _on_human_give_application() -> void:
	var application: Application = application_scene.instantiate()
	application.position = Vector2(384, 206)

	add_child(application)

func _on_setup_timer_timeout() -> void:
	$Human.speed = 200
	$DialogueTimer.start()

func _on_dialogue_timer_timeout() -> void:
	$Human.speed = 0
	continue_dialogue()

func _on_title_screen_start_game() -> void:
	$TitleScreen.hide()
	$Introduction.show()

func _on_introduction_close_introduction() -> void:
	$Introduction.hide()

func _on_client_button_next_client() -> void:
	$SetupTimer.start()

func _on_human_received_response(puppy_identifier: int) -> void:
	adopted = puppy_identifier
	continue_dialogue()

func cleanup_human() -> void:
	if adopted >= 0:
		# The puppy will walk out with him
		var pup = puppies[adopted]
		# Index 0 is Theodore. The only properly adoptable dog right now.
		if pup.index != 0:
			print("Not Theo!")
			mishoused_dog = true
		else:
			mishoused_dog = false
		pup.set_axis_velocity(Vector2(-100, 100))
		await get_tree().create_timer(1.0).timeout
		pup.set_axis_velocity(Vector2(-300, 0))

	$Human.speed = -200
	$Human/AnimatedSprite2D.stop()
	await get_tree().create_timer(2.0).timeout
	$Human.queue_free()
	end_game()

func end_game() -> void:
	$DayOver.update()
	$DayOver.show()
