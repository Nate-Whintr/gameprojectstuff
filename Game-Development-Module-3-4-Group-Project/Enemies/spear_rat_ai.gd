extends CharacterBody2D

@export var move_distance: int = 16
@export var move_speed: float = 0.5

@export var attack_damage: int = 1
@export var attack_range: int = 16
@export var detection_range: int = 160

var player: Node2D
var health: int = 3


func _ready() -> void:
	$Sprite2D.texture = preload("res://Enemies/spear_rat.png")

	$MoveCoolDown.wait_time = move_speed
	$MoveCoolDown.one_shot = true

	$AttackCoolDown.wait_time = 1.0
	$AttackCoolDown.one_shot = true

	player = get_tree().get_first_node_in_group("player") as Node2D


func _physics_process(_delta: float) -> void:
	if not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("player") as Node2D
		return

	var distance := global_position.distance_to(player.global_position)

	# Only chase the player when they are within detection range.
	if distance > detection_range:
		return

	# Attack instead of moving when the player is in an adjacent tile.
	if is_player_adjacent():
		attack_player()
		return

	if $MoveCoolDown.is_stopped():
		chase_player()


func is_player_adjacent() -> bool:
	var difference := player.global_position - global_position
	

	var horizontal := (
		absf(difference.x) <= attack_range
	)

	var vertical := (
		absf(difference.y) <= attack_range
	)
	if horizontal and vertical:
		return true
	else:
		return	false
	return horizontal or vertical



func chase_player() -> void:
	var direction := player.global_position - global_position
	var movements: Array[Vector2] = []

	# Try the axis requiring the least movement first.
	if absf(direction.x) > absf(direction.y):
		movements.append(Vector2(signf(direction.x) * move_distance, 0))
		movements.append(Vector2(0, signf(direction.y) * move_distance))
	else:
		movements.append(Vector2(0, signf(direction.y) * move_distance))
		movements.append(Vector2(signf(direction.x) * move_distance, 0))

	# Try the preferred direction, then the other axis.
	for movement in movements:
		if movement == Vector2.ZERO:
			continue

		# test_move checks walls and other physics bodies on the collision mask.
		if not test_move(global_transform, movement):
			global_position += movement
			$MoveCoolDown.start()
			return

	# If both directions are blocked, wait and try again later.
	$MoveCoolDown.start()


func attack_player() -> void:
	if not $AttackCoolDown.is_stopped():
		return

	print("Spear Rat attacks!")

	if player.has_method("take_damage"):
		player.take_damage(attack_damage)

	$AttackCoolDown.start()


func take_damage(amount = 1):
	health -= amount
	print("Spear Rat HP: ", health)

	if health <= 0:
		die()


func die():
	print("Spear Rat defeated!")
	queue_free()
