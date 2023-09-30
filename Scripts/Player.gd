extends CharacterBody2D

signal throw_item(player_pos)

const SPEED = 1000.0
var max_health = 3
var current_health = max_health
var able_to_attack = true
var attack_range = 400
var equipped_baguette = preload("res://Asset/baguette.png")
var weapon_projectile = preload("res://Scenes/weapon.tscn")

@onready var sprite = $Sprite
@onready var anim_player = $Sprite/AnimationPlayer
@onready var equippedweapon_sprite = $Weapon/EquippedWeapon

func ready():
	current_health = max_health
func _process(_delta):
	#print(State.weapon) #0=nothing #3 is baguette
	#if State.weapon==0: #free hands
		#pass
	if State.weapon==3:
		#print("got baguette!")
		equippedweapon_sprite.set_texture(equipped_baguette)
		
		
	

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
		
	# if weapons has children:
	#if Input.is_action_pressed("ui_up"):
	#	emit_signal("throw_item", position)
	if Input.is_action_pressed("ui_select"):
		if able_to_attack:
			able_to_attack = false
			$AttackTimer.start()
			_melee_attack()
	if Input.is_action_pressed("throw"):
		if able_to_attack:
			able_to_attack = false
			$AttackTimer.start()
			_throw_attack()

func _physics_process(_delta):
	get_input()
	anim_player.play("idle")
	move_and_slide()

func damaged():
	current_health -= 1
	if current_health <= 0:
		_kill()

func _kill():
	get_tree().reload_current_scene()

func _melee_attack():
	# Damage all enemies in a circular area around the player
	if $"../Enemies".get_child_count():
		for enemy in $"../Enemies".get_children():
			if (enemy.position - position).length() < attack_range:
				enemy.damaged()

func _throw_attack():
	#if not State.weapon == 0:  # Player is holding a weapon
	var weapon_projectile_instance = weapon_projectile.instantiate()
	weapon_projectile_instance.position = get_global_position()
	weapon_projectile_instance.pickupable = false
	weapon_projectile_instance.picked_up = true  # So thrown projectiles cannot be picked up mid-air
	#weapon_projectile.velocity = Vector2(10, 10)
	get_tree().get_root().call_deferred("add_child", weapon_projectile_instance)

func _on_attack_timer_timeout():
	able_to_attack = true

