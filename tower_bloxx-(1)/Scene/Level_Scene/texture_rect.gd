extends TextureRect

func _ready():
	pass

func _input_event(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and self.get_rect().has_point(event.position):
			get_tree().paused = true
