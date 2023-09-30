extends CharacterBody2D

var SPEED = 200
var able_to_attack = true

func _physics_process(delta):
	# MeleeEnemy constantly moves towards the Player and attempts to attack them
	var Player = get_node("../../CharacterBody2D")
	var direction = Player.position - position
	velocity = direction.normalized() * SPEED
	
	if direction.length() < 200:  # Stops if near player and attacks
		velocity = Vector2(0, 0)
		if able_to_attack:
			able_to_attack = false
			$Timer.start()
			_attack()
		
	move_and_slide()

func _attack():
	var Player = get_node("../../CharacterBody2D")
	Player.damaged()

func _on_timer_timeout():
	able_to_attack = true
