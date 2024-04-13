# This is an animated puppy sprite associated with a paper/db entry
class_name Puppy
extends RigidBody2D

# TODO: Put this in an _init
var index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	var animation: String = Puppies.Database[index].sprite
	
	$AnimatedSprite2D.play(animation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
