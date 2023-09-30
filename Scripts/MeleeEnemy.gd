extends CharacterBody2D

func _physics_process(delta):
	var Player = get_node("../../CharacterBody2D")
	var direction = (Player.position - position)
	velocity = direction * 1
	move_and_slide()
