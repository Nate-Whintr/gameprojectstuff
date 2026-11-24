extends Area2D
@export var dirrection = "east"
@onready var Camera2d = %"Sceen Camera"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Camera2d.camera(dirrection)
