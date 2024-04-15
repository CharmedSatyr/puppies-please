extends Sprite2D

signal next_client

func _on_button_pressed():
	next_client.emit()
