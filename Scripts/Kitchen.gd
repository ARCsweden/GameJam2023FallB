extends Node2D

@onready var player = $YSort/Player
@onready var boss = $YSort/Enemies/FrenchBoss
@onready var fade = $CanvasLayer/Fade

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO: disable movement of enemies until dialog is done
	var tween = get_tree().create_tween()
	tween.tween_property(fade, "modulate", Color(1,1,1,0), 3)
	tween.tween_callback(_trigger_dialog)
	
func _trigger_dialog():
	boss.connect("child_exiting_tree", _on_boss_defeated)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_example_dialogue_balloon(load("res://Dialog/bakery.dialogue"), "bakery_kiln")

func _on_dialogue_ended(_resource: DialogueResource):
	if State.killed_jean_pierre:
		# TODO: enable movement of enemies
		pass
	else:
		_on_boss_defeated(null)

func _on_boss_defeated(_node: Node):
	var tween = get_tree().create_tween()
	tween.tween_property(fade, "modulate", Color(1,1,1,1), 3)
	tween.tween_callback(_trigger_next_scene)

func _trigger_next_scene():
	DialogueManager.show_example_dialogue_balloon(load("res://Dialog/betrayal.dialogue"), "alleyway")
