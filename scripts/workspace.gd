extends Area2D

func _process(_delta: float) -> void:
	position = get_global_mouse_position()

	var count: int = len(get_overlapping_bodies())
	if (count == 0):
		pass
	elif (count == 1):
		get_overlapping_bodies()[0].select()
		if (Input.is_action_just_pressed("mouse_click")):
			get_parent().push_paper_to_top(get_overlapping_bodies()[0])

	else:
		var max_index: int = -1
		var top_paper: Node2D = null

		for paper in get_overlapping_bodies():
			if (paper.z_index > max_index):
				max_index = paper.z_index
				top_paper = paper

			if paper != top_paper:
				paper.is_selected = false		

		top_paper.select()

		if (Input.is_action_just_pressed("mouse_click")):
			get_parent().push_paper_to_top(top_paper)
