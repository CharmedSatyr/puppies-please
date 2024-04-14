class_name Human
extends CharacterBody2D

var speed: float = 200

@onready var dialogue_timer: Timer = $DialogueTimer

func _physics_process(delta):
	velocity.x = speed
	if velocity.x > 0:
		move_and_slide()

func _on_dialogue_timer_timeout():
	print("Human: Ready to chat!")
	$AnimatedSprite2D.play()

var dialogue_option = 0;

const dialogue = [
	"Howdy ho!",
	"Puppies, please! I summon puppies now.",
	"Here is application for puppy.",
	"Glory to A-OK #1 Animal Shelter."
]

func get_dialogue_text() -> String:
	var text: String = ""

	if (dialogue_option < dialogue.size()):
		text = dialogue[dialogue_option]
		dialogue_option += 1
	else:
		text = ""

	return text
