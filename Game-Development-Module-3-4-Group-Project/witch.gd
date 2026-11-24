extends Sprite2D
@export var MAX_HEALTH: int = 12
var health: int = 12

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("player"):
		health = body.health
		health = clampi(health + 12, 0, MAX_HEALTH)
		body.health = health
		body._update_health_hud()
