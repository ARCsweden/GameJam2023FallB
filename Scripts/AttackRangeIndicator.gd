@tool
extends Node2D

func _draw():
	if Engine.is_editor_hint():
		draw_circle(position, $"..".attack_range, Color(1.0, 0.0, 0.0))
	
func _process(delta):
	if Engine.is_editor_hint():
		queue_redraw()
