class_name Human
extends Area2D

var speed: float = 0
var velocity: Vector2 = Vector2(0, 0)

signal give_application
signal received_response

var is_approved: bool
var is_refused: bool

const END_DIALOGUE: String = "FIN"

func _process(delta) -> void:
	velocity = Vector2(speed, 0);
	position += velocity * delta

var dialogue_option: int = 0;

var dialogue: Array[String] = [
	"Howdy ho!",
	"Puppies, please! I summon puppies now.",
	"Here is application.",
	"Papers, please of glorious whelp.",
	"",
]

const response: Dictionary = {
	"on_refused": "Bahhhhh. It is a conspiracy against me!",
	"on_approved": "Thank you for puppy! I am overjoyed."
}

func get_dialogue_text() -> String:
	var text: String = ""
	
	if (dialogue_option < dialogue.size()):
		text = dialogue[dialogue_option]
		if text == "Here is application.":
			give_application.emit()
		if text == END_DIALOGUE:
			dialogue_option = 0
		dialogue_option += 1

	return text

func _on_dialogue_timer_timeout():
	$AnimatedSprite2D.play()

func _on_body_entered(body):
	if !is_approved and !is_refused:
		return

	var puppy_identifier: int

	var last_node_name = body.get_child(body.get_child_count() - 1).name
	
	if is_approved and body is Paper and last_node_name == "Adopted":
		# Index in the dictionary used to create both puppy and paper
		puppy_identifier = body.index
		body.queue_free()
		received_response.emit(puppy_identifier)
	if is_refused and body is Application and last_node_name == "NoPuppy":
		body.queue_free()
		received_response.emit()

func _on_stamp_no_puppy_stamp():
	is_approved = false
	is_refused = true
	dialogue.append(response.on_refused)
	dialogue.append(END_DIALOGUE)

func _on_stamp_puppy_stamp():
	is_approved = true
	is_refused = false
	dialogue.append(response.on_approved)
	dialogue.append(END_DIALOGUE)
