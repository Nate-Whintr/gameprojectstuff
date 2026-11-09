extends Label

var score: int = 0

func _ready() -> void:
	update_score_text()

# Call this function whenever a point is scored
func update_score(amount: int) -> void:
	score += amount
	update_score_text()

func update_score_text() -> void:
	text = "Score: " + str(score)
