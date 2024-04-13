# This is an animated puppy sprite associated with a paper/db entry
class_name Puppy
extends RigidBody2D

# TODO: Put this in an _init
var index: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var puppy_types = $AnimatedSprite2D.sprite_frames.get_animation_names()

	var animation: String = Puppies.Database[index].sprite

	if puppy_types.has(animation):
		$AnimatedSprite2D.play(animation)
	else:
		print("Missing animation: ", animation)
		$AnimatedSprite2D.play("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
