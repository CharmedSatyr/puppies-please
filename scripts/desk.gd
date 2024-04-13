class_name Desk
extends Node2D

var paper_scene: PackedScene = preload("res://Scenes/paper.tscn")
var paper_stack: Array[Paper] = []

# Number of additional papers to dynamically spawn
var spawn_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0, spawn_count):
		var paper: Paper = paper_scene.instantiate()
		add_child(paper)
		add_paper(paper)

func add_paper(paper: Paper) -> void:
	paper_stack.append(paper)
	
	var count: int = 0
	for p in paper_stack:
		p.z_index = count
		
		count += 1

func push_paper_to_top(paper: Paper) -> void:
	paper_stack.erase(paper)
	add_paper(paper)
