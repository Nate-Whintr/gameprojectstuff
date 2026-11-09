extends CharacterBody2D


@export var speed: float
var collided: bool = false
func _physics_process(delta: float) -> void:
	velocity.x = speed
	velocity.y += 10
	move_and_slide()
func _on_wall_detector_body_entered(body: Node2D) -> void:
	speed = -speed # Replace with function body.


func _on_player_colider_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		print("enemy")
	if not body.is_in_group("Player"):
		return
	collided = true
	if body.position.y < position.y:
		body.enemy_collided()
		queue_free()
	else:
		body.enemy_dieded()
	
	
	
 # Replace with function body.
