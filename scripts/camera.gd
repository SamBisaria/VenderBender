extends Camera2D

var ZOOM_MIN: Vector2   = Vector2(0.25,0.25)
var ZOOM_MAX: Vector2   = Vector2(2.5,2.5)
var zoom_speed: Vector2 = Vector2(0.3,0.3)
var PanSpeedKey: int    = 8
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called on input independent of frame times
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if zoom >= ZOOM_MIN:
				zoom -= zoom_speed
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if zoom <= ZOOM_MAX:
				zoom += zoom_speed

	#if event is InputEventMouseButton:

	#if event.is_action_pressed("zoom_out"):
		#if zoom > ZoomMin:
			#zoom -= ZoomSpd
		#print("Zoom out")
	#if event.is_action_pressed("zoom_in"):
		#if zoom < ZoomMax:
			#zoom +=ZoomSpd
		#print("Zoom in")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	# This code works for pressing multiple keys at the same time
	if Input.is_action_pressed("ui_up"):
		position.y -= PanSpeedKey
	if Input.is_action_pressed("ui_down"):
		position.y += PanSpeedKey
	if Input.is_action_pressed("ui_left"):
		position.x -= PanSpeedKey
	if Input.is_action_pressed("ui_right"):
		position.x += PanSpeedKey
	# print(position)
	pass
