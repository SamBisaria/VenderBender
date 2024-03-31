extends Camera2D

var PanSpeedKey: int = 8
var zoom_speed := 0.12
var min_zoom := 0.2
var max_zoom := 2.0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoom_speed, zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoom_speed, zoom_speed)
		zoom = Vector2(
			clamp(zoom.x, min_zoom, max_zoom),
			clamp(zoom.y, min_zoom, max_zoom)
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= PanSpeedKey
	if Input.is_action_pressed("ui_down"):
		position.y += PanSpeedKey
	if Input.is_action_pressed("ui_left"):
		position.x -= PanSpeedKey
	if Input.is_action_pressed("ui_right"):
		position.x += PanSpeedKey
