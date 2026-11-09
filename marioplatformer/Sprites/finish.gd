extends Area2D

@onready var Outlabel = $"/root/Main/CanvasLayer2/Outro"
@onready var OutRect = $"/root/Main/CanvasLayer2/OutRect"
@export var goal: int = 6
var finnished = false
func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	body.locked = true
	if body.GiftCount > goal:
		Outlabel.text = "You got enough gifts so your friend spares your life\n Press enter to restart"
	else:
		Outlabel.text = "You're a terrible friend and also dead\n Press enter to restart"
	OutRect.visible = true
	finnished = true
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and finnished:
		get_tree().reload_current_scene()


	
