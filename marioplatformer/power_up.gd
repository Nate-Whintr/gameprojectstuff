extends CharacterBody2D


@export var speed: float
var collided: bool = false
var spawned: bool = false
var spawnheight = 0
func _ready() -> void:
	spawnheight = position.y
	print(global_position)
func _physics_process(delta: float) -> void:
	if not spawned:
		velocity.y -= 1
	else:
		velocity.x = speed
		velocity.y += 10
		
	if spawnheight - 20 > position.y and not spawned:
		spawned = true
		

	move_and_slide()
func _on_wall_detector_body_entered(body: Node2D) -> void:
	speed = -speed # Replace with function body.

func _on_player_colider_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		print("enemy")
	if not body.is_in_group("Player"):
		return
	collided = true
	body.powerup(2)
	queue_free()
	
	
	
 # Replace with function body.
