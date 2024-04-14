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
