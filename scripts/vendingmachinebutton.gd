extends TextureButton

var index: int
var window_reference


func _on_pressed():
	window_reference.set_selected(index)
