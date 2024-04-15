extends CanvasLayer

func update() -> void:
	var adoption_fees = 80 if get_parent().adopted >= 0 else 0
	print("adopted? ", get_parent().adopted)

	$Income.text = """Savings: 70
Adoption Fees: %s""" % adoption_fees

	var penalty = "Dog was found unsuitable. Rehome fee: 90" if get_parent().mishoused_dog else ""

	$Expenses.text = """Food (Dogs): 30
Medicine (Dogs): 10
Facility Maintenance: 20
%s
""" % penalty

	var income = 70 + adoption_fees
	var expenses = 60 + (90 if get_parent().mishoused_dog else 0)
	$Total.text = "Total: %s" % (income - expenses)
