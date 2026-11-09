extends Label

@export var time_left: int = 400  # Mario levels typically start at 400 seconds
@export var tick_speed: float = 0.4 # How fast each Mario "second" ticks down in real seconds

@onready var timer: Timer = Timer.new()
var started = false
func _ready() -> void:
	# Configure the internal timer
	timer.wait_time = tick_speed
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	
	update_display()
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		started = true
func _on_timer_timeout() -> void:
	if started:
		if time_left > 0:
			time_left -= 1
			update_display()
			

				
		if time_left == 0:
			timer.stop()
			times_up()

func update_display() -> void:
	# Formats the integer into a 3-digit zero-padded string like "099" or "400"
	text = "Time:"+"%03d" % time_left



func times_up() -> void:
	get_tree().reload_current_scene()
	print("Time Ended")
