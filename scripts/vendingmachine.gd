extends CollisionShape2D

var window_scene: PackedScene = preload("res://scenes/window.tscn")
var window_instance = null
var rect: Rect2 = Rect2(-shape.size.x / 2, -shape.size.y / 2, shape.size.x, shape.size.y)
var local_mouse_pos: Vector2

var ITEMS: Array[Dictionary] = [{
		"imgSrc": "res://art/items/cans/blueCan.png",
		"price": 1.00,
		"stock": 10,
		"stockMax": 10
	},
	{
		"imgSrc": "res://art/items/cans/heartCan.png",
		"price": 2.00,
		"stock": 10,
		"stockMax": 10
	},
	{
		"imgSrc": "res://art/items/cans/orangeCan.png",
		"price": 1.50,
		"stock": 10,
		"stockMax": 10
	},
	{
		"imgSrc": "res://art/items/cans/stripeCan.png",
		"price": 2.75,
		"stock": 10,
		"stockMax": 10
	}
]

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		local_mouse_pos = get_local_mouse_position()
		if (rect.has_point(local_mouse_pos)):
			# print("You selected:", self.name)
			create_window(get_parent().name, ITEMS, event.position)


func create_window(title: String, items: Array[Dictionary], position: Vector2i) -> void:
	if (window_instance != null): # Only create 1
		return

	# Instantiate the window
	window_instance = window_scene.instantiate()
	
	# Set the window's properties and custom data
	window_instance.title = title
	window_instance.items = items
	window_instance.visible = true
	window_instance.position = position
	# window_instance.size = SIZE
	
	# Add the window to the scene tree
	add_child(window_instance)
	
	# Show the window
	window_instance.show()
			
