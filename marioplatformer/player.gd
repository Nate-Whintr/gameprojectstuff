extends CharacterBody2D

var startingposition = position
const FIREBALL_SCENE = preload("res://fireball.tscn")
var locked = true
var lives = 3
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -800.0
var GiftCount = 0 
@onready var LivesLabel = $"/root/Main/CanvasLayer2/Lives"

@onready var Animate = $AnimatedSprite2D
@onready var jump_sound = $JumpFx
@onready var splode = $Explode
@onready var CoinPickup = $CoinPickup
var powerstage = 1

var last_facing_direction: int = 1
func _ready():
	Animate.play("PowerDown")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		locked = false
	if not locked:
			# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_sound.play()
		
		if Input.is_action_just_pressed("Ability"):
			shoot_fireball()
		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			last_facing_direction = int(sign(direction))
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if position.y > 40:
			take_life()

		move_and_slide()
	
func collect_coin() -> void:
	GiftCount += 1
	CoinPickup.play()
	get_node("../CanvasLayer2/Score").update_score(1) # Increments by 10 points
	
func enemy_collided():
	velocity.y = JUMP_VELOCITY/2
	splode.play()
	print("collide")
	
func enemy_dieded():
	powerstage -= 1
	if powerstage <= 0:
		take_life()
	else:
		spritechange()

func powerup(power: int = 0):
	#check that the powerup isnt downgrading
	if power <= powerstage:
		return
	powerstage = power
	spritechange()
	
func spritechange():
	if powerstage == 1:
		Animate.play("PowerDown")
	if powerstage == 2:
		Animate.play("PowerUp")
	if powerstage == 3:
		Animate.play("PowerUp")
		
func shoot_fireball() -> void:
	var fireball = FIREBALL_SCENE.instantiate() as CharacterBody2D
	
	if fireball:
		# If you didn't give the script a class_name, use .set() to bypass strict typing:
		fireball.set("direction", last_facing_direction)
		
		# Position and spawn
		fireball.global_position = global_position
		get_tree().current_scene.call_deferred("add_child", fireball)
func finish():
	locked = true

func take_life():
	lives -= 1
	

	LivesLabel.text = "Lives:" + str(lives)
	if lives <= 0:
		get_tree().reload_current_scene()
	else:
		position = startingposition
		
	
	
