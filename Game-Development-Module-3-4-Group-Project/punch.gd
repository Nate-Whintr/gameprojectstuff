extends Node2D
@onready var sprite = $Punch/Fist
@onready var timer = $Timer
var speed = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spin(DEG):
	sprite.set_rotation_degrees(-DEG)


func _on_timer_timeout():
	queue_free()



func _on_punch_body_entered(body: Node2D):
	if body.is_in_group("enemy"):
		print("Hit an enemy!")
		body.take_damage(1)
