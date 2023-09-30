extends CharacterBody2D

signal throw_item(player_pos)

const SPEED = 1000.0
var max_health = 3
var current_health = 0

func ready():
	current_health = max_health

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED
	# if weapons has children:
	if Input.is_action_pressed("ui_up"):
		emit_signal("throw_item", position)

func _physics_process(delta):
	get_input()
	$Charachter/AnimationPlayer.play("idle")
	move_and_slide()

func damaged():
	current_health -= 1
	if current_health <= 0:
		kill()

func kill():
	get_tree().reload_current_scene()
