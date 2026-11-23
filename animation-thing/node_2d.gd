extends Node2D
@onready var animation = $AnimationPlayer

func _physics_process(delta):
	if Input.is_action_pressed("Wave"):
		animation.play("Wave")
	if Input.is_action_just_pressed("Idle"):
		animation.play("Idle")
