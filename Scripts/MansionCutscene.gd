extends Control

@onready var fade = $Fade
@onready var image = $Image

# Called when the node enters the scene tree for the first time.
func _ready():
	State.set_bg_image.connect(set_bg_image)
	var tween = get_tree().create_tween()
	tween.tween_property(fade, "modulate", Color(1, 1, 1, 0), 1)
	tween.tween_callback(start_dialog)

func start_dialog():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_example_dialogue_balloon(load("res://Dialog/mansion.dialogue"), "mansion_entry")

func _on_dialogue_ended(_resource: DialogueResource):
	var tween = get_tree().create_tween()
	tween.tween_property(fade, "modulate", Color(1, 1, 1, 1), 1)
	# TODO: Check state, where should we go?
	tween.tween_callback(end_game)
	
func end_game():
	get_tree().quit()

func set_bg_image(texture: Texture2D):
	image.set_texture(texture)
