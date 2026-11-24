extends CanvasLayer
class_name PlayerHealth

signal health_changed(current_quarters: int, max_quarters: int)
signal died

@export var max_hearts: int = 3
@export var quarters_per_heart: int = 4

var max_health: int
var health: int

@onready var heart_1: TextureProgressBar = $HUD/Heart1
@onready var heart_2: TextureProgressBar = $HUD/Heart2
@onready var heart_3: TextureProgressBar = $HUD/Heart3

func _ready() -> void:
	max_health = max_hearts * quarters_per_heart
	health = max_health
	_update_hud()

func take_damage(amount: int = 1) -> void:
	if amount <= 0 or health <= 0:
		return

	health = max(health - amount, 0)
	_update_hud()
	health_changed.emit(health, max_health)

	if health == 0:
		died.emit()

func heal(amount: int = 1) -> void:
	if amount <= 0 or health <= 0:
		return

	health = min(health + amount, max_health)
	_update_hud()
	health_changed.emit(health, max_health)

func get_health() -> int:
	return health

func _update_hud() -> void:
	var remaining := health

	for heart in [heart_1, heart_2, heart_3]:
		heart.max_value = quarters_per_heart
		heart.value = clamp(remaining, 0, quarters_per_heart)
		remaining -= quarters_per_heart
