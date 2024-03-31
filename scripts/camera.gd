extends Camera2D

var PanSpeedKey: int = 8
var zoom_speed := 0.1
var zoom_smoothness := 5.0
var min_zoom := 0.2
var max_zoom := 2.0
var target_zoom := Vector2(1.0, 1.0)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			target_zoom += Vector2(zoom_speed, zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			target_zoom -= Vector2(zoom_speed, zoom_speed)
		
		target_zoom = Vector2(
			clamp(target_zoom.x, min_zoom, max_zoom),
			clamp(target_zoom.y, min_zoom, max_zoom)
		)

func _process(delta):
	zoom = lerp(zoom, target_zoom, delta * zoom_smoothness)
	if Input.is_action_pressed("ui_up"):
		position.y -= PanSpeedKey
	if Input.is_action_pressed("ui_down"):
		position.y += PanSpeedKey
	if Input.is_action_pressed("ui_left"):
		position.x -= PanSpeedKey
	if Input.is_action_pressed("ui_right"):
		position.x += PanSpeedKey
