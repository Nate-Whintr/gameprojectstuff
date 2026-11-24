extends Camera2D
@onready var player = %Slime

func camera(direction):
	if direction == "east":
		position.x += 288
		player.position.x += 32
	if direction == "west":
		position.x -= 288
		player.position.x -= 32
	if direction == "north":
		position.y -= 208
		player.position.y -= 32
	if direction == "south":
		position.y += 208
		player.position.y += 32
