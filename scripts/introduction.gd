extends CanvasLayer

signal close_introduction

func _on_button_pressed():
	close_introduction.emit()
