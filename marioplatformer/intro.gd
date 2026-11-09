extends Label
@onready var background = $"/root/Main/CanvasLayer2/ColorRect"
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		queue_free() # Deletes this Label node from the scene tree
		background.queue_free()
