class_name Human
extends CharacterBody2D

var speed: float = 0

signal give_application

func _physics_process(delta):
	velocity.x = speed
	if velocity.x > 0:
		move_and_slide()

var dialogue_option = 0;

const dialogue = [
	"Howdy ho!",
	"Puppies, please! I summon puppies now.",
	"Here is application.",
	"Papers, please of glorious whelp."
]

func get_dialogue_text() -> String:
	var text: String = ""
	if (dialogue_option < dialogue.size()):
		text = dialogue[dialogue_option]

		if text == "Here is application.":
			give_application.emit()	

		dialogue_option += 1
	else:
		text = ""
	return text

func _on_dialogue_timer_timeout():
	$AnimatedSprite2D.play()
