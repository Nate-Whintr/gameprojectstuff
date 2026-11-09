extends StaticBody2D
var collected = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") or collected:
			return
	collected = true
	body.collect_coin()
	
