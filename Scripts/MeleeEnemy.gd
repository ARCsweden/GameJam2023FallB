extends CharacterBody2D

var SPEED = 200
var max_health = 1
var current_health = max_health
var able_to_attack = true
var attack_range = 200
var weapon = preload("res://Scenes/weapon.tscn")

@onready var sprite = $Sprite
@onready var anim_player = $AnimationPlayer

func _draw():
	draw_circle_arc(position-get_global_position(), attack_range, 0, 360, Color(1.0, 0.0, 0.0))
	
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
	# MeleeEnemy constantly moves towards the Player and attempts to attack them
	var player = get_node("../../Player")
	var direction = player.position - position
	velocity = direction.normalized() * SPEED
	
	if velocity.x > 0:
		sprite.scale.x = 1
	elif velocity.x < 0:
		sprite.scale.x = -1
	
	if direction.length() < attack_range:  # Stops if near player and attacks
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
	# Spawn weapon on death
	var weapon_instance = weapon.instantiate()
	weapon_instance.position = get_global_position()
	get_tree().get_root().call_deferred("add_child", weapon_instance)
	queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("projectiles"):
		body.queue_free()
		damaged()
		
