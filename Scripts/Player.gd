extends CharacterBody2D

signal throw_item(player_pos)

const SPEED = 1000.0
var max_health = 3
var current_health = max_health
var able_to_attack = true
var attack_range = 400

func ready():
	current_health = max_health

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED
	# if weapons has children:
	#if Input.is_action_pressed("ui_up"):
	#	emit_signal("throw_item", position)
	if Input.is_action_pressed("ui_select"):
		if able_to_attack:
			able_to_attack = false
			$AttackTimer.start()
			_attack()

func _physics_process(delta):
	get_input()
	$Charachter/AnimationPlayer.play("idle")
	move_and_slide()

func damaged():
	current_health -= 1
	if current_health <= 0:
		_kill()

func _kill():
	get_tree().reload_current_scene()


func _attack():
	# Damage all enemies in range
	if get_tree().root.get_node("Weapon").get_child_count():
		for enemy in get_tree().root.get_node("Weapon").get_children():
			if (enemy.position - position).length() < attack_range:
				enemy.damaged()
	
func _on_attack_timer_timeout():
	able_to_attack = true

