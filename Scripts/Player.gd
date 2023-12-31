extends CharacterBody2D

signal throw_item(player_pos)

var SPEED = 1000.0
var max_health = 3
var current_health = max_health
var able_to_attack = false
var attack_range = 160
var projectile_speed = 1000
var equipped_baguette = preload("res://Asset/baguette.png")
var weapon_projectile = preload("res://Scenes/weapon.tscn")
var COLOR_RED = Color(1.0, 0.0, 0.0)
var COLOR_GREEN = Color(0.0, 1.0, 0.0)
var circle_color = COLOR_RED

@onready var sprite = $Sprite
@onready var anim_player = $AnimationPlayer
@onready var equippedweapon_sprite = $Weapon/EquippedWeapon

func _ready():
	current_health = max_health
	anim_player.play("idle")

func _process(delta):
	queue_redraw()
	$"HP label".text = str(current_health) + " HP"
	#print(State.weapon)
	if State.weapon==State.Weapon.Baguette:
		#print("got baguette!")
		equippedweapon_sprite.set_texture(equipped_baguette)
	#print(State.weapon) #0=nothing #2 is baguette
	if State.weapon==State.Weapon.Nothing: #free hands
		equippedweapon_sprite.set_texture(null)

func _draw():
	if able_to_attack:
		circle_color = COLOR_GREEN
	else:
		circle_color = COLOR_RED
	draw_circle_arc(Vector2(), attack_range, 0, 360, circle_color)

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED
	if velocity.x > 0:
		sprite.scale.x = 1
	elif velocity.x < 0:
		sprite.scale.x = -1
		
	# if weapons has children:
	#if Input.is_action_pressed("ui_up"):
	#	emit_signal("throw_item", position)
	if Input.is_action_pressed("melee"):
		if able_to_attack:
			able_to_attack = false
			$AttackTimer.start()
			_melee_attack()
	if Input.is_action_pressed("throw"):
		if able_to_attack:
			if not State.weapon == State.Weapon.Nothing:  # Player is holding a weapon
				able_to_attack = false
				$AttackTimer.start()
				_throw_attack()

func _physics_process(_delta):
	get_input()
	move_and_slide()

func damaged():
	current_health -= 1
	if current_health <= 0:
		_kill()

func _kill():
	get_tree().reload_current_scene()

func _melee_attack():
	anim_player.play("attack")
	# Damage all enemies in a circular area around the player
	if $"../Enemies".get_child_count():
		for enemy in $"../Enemies".get_children():
			if (enemy.position - position).length() < attack_range:
				enemy.damaged()

func _throw_attack():
	State.weapon = State.Weapon.Nothing
	anim_player.play("attack")
	var weapon_projectile_instance = weapon_projectile.instantiate()
	var direction = get_global_position().direction_to(get_global_mouse_position())
	weapon_projectile_instance.position = get_global_position() + direction * 100
	weapon_projectile_instance.configure_as_projectile()
	weapon_projectile_instance.apply_impulse(direction * projectile_speed, Vector2())
	weapon_projectile_instance.look_at(global_transform.origin + direction)
	get_tree().get_root().call_deferred("add_child", weapon_projectile_instance)

func _on_attack_timer_timeout():
	able_to_attack = true

