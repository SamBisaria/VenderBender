extends Camera2D

var PanSpeedKey: int    = 8

var zoomspeed: int    = 100
var zoommargin: float = 0.3

var zoomMin: float = 0.2
var zoomMax: int   = 1

var zoompos: Vector2  = Vector2()
var zoomfactor: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called on input independent of frame times
func _input(event: InputEvent) -> void:
	if (abs(zoompos.x - get_global_mouse_position().x) > zoommargin):
		zoomfactor = 1.0
	if (abs(zoompos.y - get_global_mouse_position().y) > zoommargin):
		zoomfactor = 1.0
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoomfactor -= 0.01
				zoompos = get_global_mouse_position()
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoomfactor += 0.01
				zoompos = get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	zoom.x = lerp(zoom.x, zoom.x * zoomfactor, zoomspeed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoomfactor, zoomspeed * delta)
	zoom.x = clamp(zoom.x, zoomMin, zoomMax)
	zoom.y = clamp(zoom.y, zoomMin, zoomMax)
	
	# This code works for pressing multiple keys at the same time
	if Input.is_action_pressed("ui_up"):
		position.y -= PanSpeedKey
	if Input.is_action_pressed("ui_down"):
		position.y += PanSpeedKey
	if Input.is_action_pressed("ui_left"):
		position.x -= PanSpeedKey
	if Input.is_action_pressed("ui_right"):
		position.x += PanSpeedKey
