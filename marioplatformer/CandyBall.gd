extends CharacterBody2D

@export var speed: float = 300.0
@export var bounce_velocity: float = -250.0
@export var gravity: float = 800.0

var direction: int = 1  # Passed from the player

func _ready() -> void:
	# Initialize the forward movement
	velocity.x = speed * direction
	velocity.y = 100.0 # Initial downward push
	print("spawned")
func _physics_process(delta: float) -> void:
	# Apply gravity using the modern Godot 4 project settings call or a hardcoded value
	velocity.y += gravity * delta
	
	# Godot 4 move_and_slide() uses the internal 'velocity' variable automatically
	move_and_slide()
	
	# Check for floor bounce
	if is_on_floor():
		velocity.y = bounce_velocity
		velocity.x = speed * direction
		
	# Check for wall collision to destroy it
	if is_on_wall():
		queue_free()
