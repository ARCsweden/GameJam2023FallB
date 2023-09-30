extends RigidBody2D

var picked_up = false
var pickupable= false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pickupable and (Input.is_action_just_pressed("pickup")) and not picked_up:
		$WeaponSprite2D.visible=false
		$interact.visible=false 
		picked_up = true


func _on_weapon_pickup_area_2d_body_entered(body):
	if not picked_up:
		$interact.visible=true
		pickupable= true

func _on_weapon_pickup_area_2d_body_exited(body):
	$interact.visible=false 
