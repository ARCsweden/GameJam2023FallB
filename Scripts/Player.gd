extends CharacterBody2D

signal throw_item(player_pos)

const SPEED = 1000.0

func ready():
	print("hello")
	


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
