extends RigidBody2D

var pickupable= false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pickupable and (Input.is_action_just_pressed("pickup")):
		$WeaponSprite2D.visible=false
		$interact.visible=false 


func _on_weapon_pickup_area_2d_body_entered(body):
	$interact.visible=true
	pickupable= true
	


func _on_weapon_pickup_area_2d_body_exited(body):
	$interact.visible=false 
