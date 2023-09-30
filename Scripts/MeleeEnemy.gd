extends CharacterBody2D

var SPEED = 200

func _physics_process(delta):
	# MeleeEnemy constantly moves towards the Player and attempts to attack them
	var Player = get_node("../../CharacterBody2D")
	var direction = Player.position - position
	velocity = direction.normalized() * SPEED
	if direction.length() < 200:  # Stops if near player and attacks
		velocity = Vector2(0, 0)
		_attack()
	move_and_slide()

func _attack():
	var Player = get_node("../../CharacterBody2D")
	Player.damaged()
