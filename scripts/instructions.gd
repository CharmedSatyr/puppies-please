class_name Instructions
extends DraggablePaper

var text: Array[String] = [
"""- Press button for client.
- Client submits application.
- Only clients with pet experience get a puppy.
- Green stamp puppy paper if there is a good match.
- Red stamp client application if there is not a good match.""",
"""- Give stamped puppy dossier to successful applicants.
- Return stamped Application to failed applicants."""
]

var page = 0

func _ready() -> void:
	$Details.text = text[page]
	$PageNumber.text = "Page " + str(page + 1)

func _on_page_corner_pressed():
	if page == 0:
		page = 1
	elif page == 1:
		page = 0

	$Details.text = text[page]
	$PageNumber.text = "Page " + str(page + 1)
