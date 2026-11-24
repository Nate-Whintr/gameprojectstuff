extends CharacterBody2D

@export var patrol_speed: float = 24.0
@export var patrol_distance: float = 48.0

var direction: float = 1.0
var start_x: float
var health: int = 3
@export var contact_damage: int = 1
@export var damage_cooldown: float = 0.5
var damage_timer: float = 0.0

func _ready() -> void:
	start_x = global_position.x
	add_to_group("enemy")

func _physics_process(delta: float) -> void:
	if damage_timer > 0.0:
		damage_timer -= delta

	velocity = Vector2(direction * patrol_speed, 0.0)
	var collision := move_and_collide(velocity * delta)

	if collision:
		var collider := collision.get_collider()
		if damage_timer <= 0.0 and collider is Node2D and collider.is_in_group("player") and collider.has_method("take_damage"):
			collider.take_damage(contact_damage)
			damage_timer = damage_cooldown

		direction *= -1.0
		$Sprite2D.flip_h = direction < 0.0
		return

	if absf(global_position.x - start_x) >= patrol_distance:
		global_position.x = start_x + (patrol_distance * direction)
		direction *= -1.0
		$Sprite2D.flip_h = direction < 0.0

func take_damage(amount = 1):
	health -= amount
	print("Patrol Rat HP: ", health)

	if health <= 0:
		die()

func die():
	print("Patrol Rat defeated!")
	queue_free()
