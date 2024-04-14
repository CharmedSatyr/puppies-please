class_name Human
extends Area2D

var speed: float = 0
var velocity: Vector2 = Vector2(0, 0)

signal give_application

var is_approved: bool
var is_refused: bool

func _process(delta):
	velocity = Vector2(speed, 0);
	position += velocity * delta

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

func _on_body_entered(body):
	if !is_approved and !is_refused:
		return

	if body is Application:
		body.queue_free()
	if is_approved and body is Paper:
		body.queue_free()
	if is_refused and body is Application:
		body.queue_free()

func _on_stamp_no_puppy_stamp():
	is_approved = false
	is_refused = true

func _on_stamp_puppy_stamp():
	is_approved = true
	is_refused = false
