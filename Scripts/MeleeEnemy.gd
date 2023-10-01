extends CharacterBody2D

var SPEED = 200
var max_health = 1
var current_health = max_health
var able_to_attack = true

@onready var sprite = $Sprite
@onready var anim_player = $AnimationPlayer

func _physics_process(_delta):
	# MeleeEnemy constantly moves towards the Player and attempts to attack them
	var player = get_node("../../Player")
	var direction = player.position - position
	velocity = direction.normalized() * SPEED
	
	if velocity.x > 0:
		sprite.scale.x = 1
	elif velocity.x < 0:
		sprite.scale.x = -1
	
	if direction.length() < 200:  # Stops if near player and attacks
		velocity = Vector2(0, 0)
		if able_to_attack:
			able_to_attack = false
			$Timer.start()
			_attack()
		
	move_and_slide()

func _attack():
	var player = get_node("../../Player")
	player.damaged()

func _on_timer_timeout():
	able_to_attack = true

func damaged():
	current_health -= 1
	if current_health <= 0:
		_kill()
		
func _kill():
	queue_free()
