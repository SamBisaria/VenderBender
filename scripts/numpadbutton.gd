extends Button

var charge_price_input: TextEdit

func _ready():
	charge_price_input = get_node("../../../MarginContainer/ChargePriceInput")
	
func _on_pressed():
	charge_price_input.set_text(price(charge_price_input.get_text(), self.name))

func price(current: String, pressed: String) -> String:
	var output: String
	if current == "" or current == null:
		output = "$"
	else:
		output = current
	
	if pressed == "dot":
		pressed = "."
	elif pressed == "backspace":
		return current.substr(0, len(current) - 1)
	
	output = output + pressed
	return output
