extends PanelContainer

var balance: float = 0.00
@onready var label: Label = find_child("Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "Balance: $" + str(balance).pad_decimals(2)


func _on_sugar_rush_purchase(balance_change):
	balance += balance_change
