extends Control

@onready var fade = $Fade
@onready var image = $image

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(fade, "modulate", Color(1, 1, 1, 0), 1)
	tween.tween_callback(start_dialog)

func start_dialog():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_example_dialogue_balloon(load("res://Dialog/intro.dialogue"), "monaco_arrival")

func _on_dialogue_ended(_resource: DialogueResource):
	var tween = get_tree().create_tween()
	tween.tween_property(fade, "modulate", Color(1, 1, 1, 1), 1)
	tween.tween_callback(goto_bakery)	
	
func goto_bakery():
	get_tree().change_scene_to_file("res://Scenes/Bakery.tscn")
