class_name Workspace
extends Area2D

func _process(_delta: float) -> void:
	position = get_global_mouse_position()

	var stack = get_overlapping_bodies() as Array[Paper]

	var count: int = len(stack)

	if (count == 0):
		pass
	elif (count == 1):
		var paper: Paper = stack[0]
		paper.select()
		if (Input.is_action_just_pressed("mouse_click")):
			get_parent().push_paper_to_top(paper)

	else:
		var max_index: int = -1
		var top_paper: Paper = null

		for paper in stack:
			if (paper.z_index > max_index):
				max_index = paper.z_index
				top_paper = paper

			if paper != top_paper:
				paper.is_selected = false

		top_paper.select()

		if (Input.is_action_just_pressed("mouse_click")):
			get_parent().push_paper_to_top(top_paper)
