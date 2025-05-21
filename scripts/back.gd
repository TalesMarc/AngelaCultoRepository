extends TextureButton

func _ready():
	self.mouse_entered.connect(_on_mouse_entered)
	self.pressed.connect(_on_pressed)

func _on_mouse_entered():
	var som_node = get_node("../hover_sound")
	if som_node:
		som_node.play()

func _on_pressed():
	var som_node = get_node("../click_sound")
	if som_node:
		som_node.play()
