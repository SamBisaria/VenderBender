extends Window

var items: Array[Dictionary]
var buttons_container: GridContainer
var vending_button: PackedScene = preload("res://scenes/vending_button.tscn")

func _ready():
	buttons_container = find_child("VendingMachineItems")
	create_buttons(items.size())

#	size_changed.connect(_on_size_changed)

#func _on_size_changed():
#	resize_buttons()

func create_buttons(button_count):
	buttons_container.set_columns(items.size() / 2) # Hardcoded for now don't have time
	var item_container: Container
	var button: TextureButton
	var fill_bar: ProgressBar
	var price_label: Label
	for i in range(button_count):
		item_container = vending_button.instantiate()
		button = item_container.find_child("TextureButton")
		button.texture_normal = load(items[i].imgSrc)
		fill_bar = item_container.find_child("ProgressBar")
		fill_bar.set_value(items[i].stock)
		fill_bar.set_max(items[i].stockMax)
		price_label = item_container.find_child("Label")
		price_label.set_text("$" + str(items[i].price).pad_decimals(2))
		buttons_container.add_child(item_container)

#func resize_buttons():
#	var container_width: float = buttons_container.size.x
#	var button_width: float =    container_width / buttons_container.get_child_count()
#
#	for button in buttons_container.get_children():
#		button.size = Vector2(button_width, button.size.y)

func _on_close_requested():
	queue_free()
