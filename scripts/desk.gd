extends Node2D

var paper_stack: Array[PackedScene] = []

var paper_scene: PackedScene = preload("res://Scenes/paper.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0, 2):
		var paper: Node = paper_scene.instantiate()
		add_paper(paper)

func add_paper(paper: Node) -> void:
	paper_stack.append(paper)
	
	var count: int = 0
	for p in paper_stack:
		p.z_index = count
		
		count += 1

func push_paper_to_top(paper: Node) -> void:
	paper_stack.erase(paper)
	add_paper(paper)
