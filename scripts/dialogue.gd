extends CanvasLayer

# Notifies `Game` node that the button has been pressed
signal next_message

func show_message(text: String) -> void:
	$TextBox/NextButton.hide()
	$TextBox/Message.text = text
	await get_tree().create_timer(1.0).timeout
	$TextBox/NextButton.show()

func _on_next_button_pressed():
	next_message.emit()
