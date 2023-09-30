extends Node2D

var SPEED = 1500
var direction = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * SPEED

func _on_throw_item(player_position):
	pass
	#var new_direction = get_global_mouse_position() - player_position
	#direction = new_direction.normalized
