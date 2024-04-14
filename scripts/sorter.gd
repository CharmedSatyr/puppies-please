# This class helps you sort papers
class_name Desk
extends Area2D

var adopted_stamp: PackedScene = preload("res://scenes/adopted.tscn")
var no_puppy_stamp: PackedScene = preload("res://scenes/no_puppy.tscn")

func _process(_delta: float) -> void:
	position = get_global_mouse_position()

	var stack: Array[Node2D] = get_overlapping_bodies()
		
	var count: int = len(stack)

	if (count == 0):
		pass
	elif (count == 1):
		var paper: Node2D = stack[0]
		paper.select()
		if (Input.is_action_just_pressed("mouse_click")):
			get_parent().push_paper_to_top(paper)
	else:
		var max_index: int = -1
		var top_paper: Node2D = null

		for paper in stack:
			if (paper.z_index > max_index):
				max_index = paper.z_index
				top_paper = paper
			if paper != top_paper:
				paper.is_selected = false

		top_paper.select()

		if (Input.is_action_just_pressed("mouse_click")):
			get_parent().push_paper_to_top(top_paper)

func _on_stamp_puppy_stamp():
	var stack: Array[Node2D] = []
	# The stamp gets included in overlapping bodies
	# Exclude it
	for object in get_overlapping_bodies():
		if object is Paper:
			stack.append(object)

	if stack.size() == 1:
		var stamp = adopted_stamp.instantiate();
		stack[0].add_child(stamp)

func _on_stamp_no_puppy_stamp():
	var stack: Array[Node2D] = []
	# The stamp gets included in overlapping bodies
	# Exclude it
	for object in get_overlapping_bodies():
		if object is Application:
			stack.append(object)

	if stack.size() == 1:
		var stamp = no_puppy_stamp.instantiate();
		stack[0].add_child(stamp)
