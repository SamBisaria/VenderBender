extends Window

var items: Array[Dictionary]
var queue: Array
var vending_machine
var selected_item_index: int
var buttons_container: GridContainer
var customer_order_preview: TextureRect
var charge_price_box: TextEdit
var audio

var vending_button: PackedScene = preload("res://scenes/vending_button.tscn")

func _ready():
	buttons_container = find_child("VendingMachineItems")
	customer_order_preview = find_child("CustomWantsPicture")
	charge_price_box = find_child("ChargePriceInput")
	create_buttons(items.size())


func _process(delta: float) -> void:
	var item_containers = buttons_container.get_children()
	for i in range(len(item_containers)):
		var item_container = item_containers[i]
		var fill_bar = item_container.find_child("ProgressBar")
		fill_bar.set_value(items[i].stock)
	
	if len(queue) > 0:
		customer_order_preview.texture = load(items[queue[0]].imgSrc)
	else:
		customer_order_preview.texture = null
		
	


func create_buttons(button_count):
	buttons_container.set_columns(items.size() / 2) # Hardcoded for now don't have time
	var item_container: Container
	var button: TextureButton
	var fill_bar: ProgressBar
	var price_label: Label
	for i in range(button_count):
		item_container = vending_button.instantiate()
		button = item_container.find_child("TextureButton")
		button.index = i
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


func _on_dispense_pressed():
	if (len(queue) > 0):
		var profit = handle_purchase(selected_item_index)
		vending_machine.update_balance(profit)


func _on_do_nothing_pressed():
	if (len(queue) > 0):
		var profit = handle_purchase(-1)
		vending_machine.update_balance(profit)

func handle_purchase(selected_item) -> float:
	if (charge_price_box.text == null or charge_price_box.text == "" or selected_item_index == null):
		play_error_sound()
		return 0
	
	var company_expects: float = items[queue[0]].price
	var you_charged: float
	
	var temp: String = charge_price_box.text
	if temp.begins_with("$"):
		temp = temp.substr(1, len(temp) - 1)
	
	you_charged = float(temp)
	
	if selected_item == -1:
		pass
	elif (items[selected_item].stock) <= 0:
		## Play error sound here?
		play_error_sound()
		return 0
	else:
		items[selected_item].stock -= 1
	
	charge_price_box.clear()
	queue.pop_front()
	return you_charged - company_expects
		
	
	
func play_error_sound() -> void:
	audio.play()
	
