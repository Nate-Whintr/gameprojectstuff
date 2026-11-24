extends Area2D
@export var piece_number = 1


func _on_body_entered(body: Node2D) -> void:
	if piece_number == 1:
		GameManager.rune_piece_1 = true
		barrier_check()
		queue_free()
	elif piece_number == 2:
		GameManager.rune_piece_2 = true
		barrier_check()
		queue_free()
	elif piece_number == 3:
		GameManager.rune_piece_3 = true
		barrier_check()
		queue_free()

func barrier_check():
	if GameManager.rune_piece_1 == true and GameManager.rune_piece_2 == true and GameManager.rune_piece_3 == true:
		get_node("%Barrier").queue_free()
