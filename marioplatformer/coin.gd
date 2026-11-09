extends Area2D
var iscollected: bool = false
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body) -> void:
	
	if not body.is_in_group("Player") or iscollected:
		return
	iscollected = true
	body.collect_coin()
	queue_free()
	
