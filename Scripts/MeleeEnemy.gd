extends CharacterBody2D

var SPEED = 200
@export var max_health = 1
var current_health = max_health
var able_to_attack = true
var winding_up = false
var attack_range = 200
var weapon = preload("res://Scenes/weapon.tscn")
var COLOR_RED = Color(1.0, 0.0, 0.0)
var COLOR_GREEN = Color(0.0, 1.0, 0.0)
var COLOR_YELLOW = Color(255.0, 255.0, 0.0)
var circle_color = COLOR_RED

@onready var sprite = $Sprite
@onready var anim_player = $AnimationPlayer
@onready var hp_label = $HPLabel
@onready var windup_timer = $AttackWindupTimer

func _draw():
	if winding_up:
		circle_color = COLOR_YELLOW
	elif able_to_attack:
		circle_color = COLOR_GREEN
	else:
		circle_color = COLOR_RED
	draw_circle_arc(position-get_global_position(), attack_range, 0, 360, circle_color)
	
func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func _physics_process(_delta):
	queue_redraw()
	#hp_label.text = str(current_health) + " HP"
	# MeleeEnemy constantly moves towards the Player and attempts to attack them
	var player = get_node("../../Player")
	var direction = player.position - position
	velocity = direction.normalized() * SPEED
	
	if velocity.x > 0:
		sprite.scale.x = 1
	elif velocity.x < 0:
		sprite.scale.x = -1
	
	#if direction.length() < attack_range:  # Stops if near player and attacks
	if is_player_in_range():
		velocity = Vector2(0, 0)
		if able_to_attack:
			able_to_attack = false
			_attack()
		
	move_and_slide()

func is_player_in_range():
	var player = get_node("../../Player")
	var direction = player.position - position
	if direction.length() < attack_range:
		return true
	return false

func _attack():
	windup_timer.start()
	winding_up = true

func _on_timer_timeout():
	able_to_attack = true

func damaged():
	current_health -= 1
	if current_health <= 0:
		_kill()
		
func _kill():
	State.bakery_killed_staff = true
	# Spawn weapon on death
	var weapon_instance = weapon.instantiate()
	weapon_instance.position = get_global_position()
	get_tree().get_root().call_deferred("add_child", weapon_instance)
	queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("projectiles"):
		body.queue_free()
		damaged()
		


func _on_attack_windup_timer_timeout():
	if is_player_in_range():
		var player = get_node("../../Player")
		player.damaged()
	winding_up = false
	$Timer.start()
