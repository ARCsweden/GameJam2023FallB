extends RigidBody2D

var picked_up = false
var pickupable= false
@onready var item=get_node("CollisionShape2D") # Replace with function body.

# Called when the node enters the scene tree for the first time.
func _ready():
	item.set_disabled(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pickupable and (Input.is_action_just_pressed("pickup")) and not picked_up:
		$WeaponSprite2D.visible=false
		$interact.visible=false 
		picked_up = true
		#change state of weapon using global weapon
		State.weapon=State.Weapon.Baguette
		item.set_disabled(true) #tar bort collision
		queue_free() #tar faktiskt bort Weapon objektet
		
		
		


func _on_weapon_pickup_area_2d_body_entered(body):
	if not picked_up:
		$interact.visible=true
		pickupable= true

func _on_weapon_pickup_area_2d_body_exited(body):
	$interact.visible=false 

func configure_as_projectile():
	$interact.visible=false
	pickupable=false
	picked_up=true
	add_to_group("projectiles")
	
func configure_as_pickupable():
	pickupable=true
	picked_up=false
	freeze = 1
	rotation_degrees = 0
