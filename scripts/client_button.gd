extends Sprite2D

signal next_client

var enabled: bool = true

func _on_button_pressed():
	if enabled:
		$BuzzerSound.play()
		next_client.emit()
		enabled = false
