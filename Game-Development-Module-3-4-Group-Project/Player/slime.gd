extends CharacterBody2D
@export var punch_scene: PackedScene
const STATE = ["IDLE", "WALK", "ATTACK"]
var cooldown_move = 0.2

func change_state(New_State):
	if New_State == "IDLE":
		pass
	else:
		pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("move_left"):
		$Sprite2D.set_rotation_degrees(90)
		if $MoveCoolDown.is_stopped():
			if $"RayCast West".is_colliding() == false:
				position.x -= 16
				$MoveCoolDown.start(cooldown_move)
	elif Input.is_action_pressed("move_right"):
		$Sprite2D.set_rotation_degrees(270)
		if $MoveCoolDown.is_stopped():
			if $"RayCast East".is_colliding() == false:
				position.x += 16
				$MoveCoolDown.start(cooldown_move)
	elif Input.is_action_pressed("move_up"):
		$Sprite2D.set_rotation_degrees(180)
		if $MoveCoolDown.is_stopped():
			if $"RayCast North".is_colliding() == false:
				position.y -= 16
				$MoveCoolDown.start(cooldown_move)
	elif Input.is_action_pressed("move_down"):
		$Sprite2D.set_rotation_degrees(0)
		if $MoveCoolDown.is_stopped():
			if $"RayCast South".is_colliding() == false:
				position.y += 16
				$MoveCoolDown.start(cooldown_move)
	elif Input.is_action_pressed("attack"):
		punch()

func punch():
	$MoveCoolDown.start(0.5)
	var punch = punch_scene.instantiate()
	get_tree().current_scene.add_child(punch)
	var rotation = $Sprite2D.rotation_degrees
	var offset = 25.0
	var player_position = global_position + Vector2(8, 0)
	if rotation == 180:
		punch.global_position = $MarkerUP.global_position
		punch.spin(0)
	elif rotation == 0:
		punch.global_position = $MarkerDOWN.global_position
		punch.spin(180)
	elif rotation == 90:
		punch.global_position = $MarkerLEFT.global_position
		punch.spin(90)
	elif rotation == 270:
		punch.global_position = $MarkerRIGHT.global_position
		punch.spin(270)

const MAX_HEALTH := 12
var health := MAX_HEALTH
var health_hud: CanvasLayer
var health_bars: Array[TextureProgressBar] = []
var dead := false

func _ready() -> void:
	$Sprite2D.remove_from_group("player")
	add_to_group("player")
	_create_health_hud()

func take_damage(amount: int = 1) -> void:
	if dead:
		return
	print(amount)
	health = maxi(health - amount, 0)
	_update_health_hud()

	if health <= 0:
		dead = true
		set_process_input(false)
		velocity = Vector2.ZERO
		print("Player defeated!")


func _create_health_hud() -> void:
	health_hud = CanvasLayer.new()
	health_hud.layer = 10
	get_tree().current_scene.add_child.call_deferred(health_hud)

	var container := HBoxContainer.new()
	container.position = Vector2(4, 4)
	container.add_theme_constant_override("separation", 1)
	health_hud.add_child.call_deferred(container)

	for i in range(3):
		var heart := TextureProgressBar.new()
		heart.custom_minimum_size = Vector2(16, 16)
		heart.size = Vector2(16, 16)
		heart.texture_under = preload("res://UI_heart.png")
		heart.texture_progress = preload("res://UI_heart.png")
		heart.tint_under = Color(0.12, 0.12, 0.12, 1.0)
		heart.tint_progress = Color.WHITE
		heart.fill_mode = TextureProgressBar.FILL_LEFT_TO_RIGHT
		heart.value = 100
		heart.max_value = 100
		container.add_child(heart)
		health_bars.append(heart)

	_update_health_hud()

func _update_health_hud() -> void:
	for i in range(health_bars.size()):
		var heart_health := clampi(health - (i * 4), 0, 4)
		health_bars[i].value = float(heart_health) * 25.0
