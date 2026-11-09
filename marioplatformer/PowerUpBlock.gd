extends StaticBody2D
var collected = false
const POWER_UP = preload("res://PowerUp.tscn")
const FIRE_UP = preload("res://Fire_up.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") or collected:
			return
	if body.powerstage == 1:
		var power_up_instance = POWER_UP.instantiate()
		power_up_instance.global_position = position
		add_child.call_deferred(power_up_instance)
	else: 
		var fire_up_instance = FIRE_UP.instantiate()
		fire_up_instance.global_position = position
		add_child.call_deferred(fire_up_instance)
	print(body.powerstage)
	collected = true
