class_name Human
extends CharacterBody2D

var speed: float = 200

func _physics_process(delta):
	velocity.x = speed
	if velocity.x > 0:
		move_and_slide()

var dialogue_option = 0;

const dialogue = [
	"Howdy ho!",
	"Puppies, please! I summon puppies now.",
	"Here is application for puppy.",
	"Rustle your papers and find me match.",
	"Please give me papers of my new puppy."
	#"Glory to A-OK #1 Animal Shelter."
]

func get_dialogue_text() -> String:
	var text: String = ""
	if (dialogue_option < dialogue.size()):
		text = dialogue[dialogue_option]
		dialogue_option += 1
	else:
		text = ""
	return text

func _on_setup_timer_timeout():
	$AnimatedSprite2D.play()
