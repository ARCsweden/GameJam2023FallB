extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_weapon_pickup_area_2d_body_entered(body):
	$interact.visible=true


func _on_weapon_pickup_area_2d_body_exited(body):
	$interact.visible=false #ta bort sedan endast via use(key P)
