extends Node2D

@onready var player = $YSort/Player
@onready var back_entrance_spawn = $BackEntranceSpawn

# Called when the node enters the scene tree for the first time.
func _ready():
	if State.entry_point == State.EntryPoint.Back:
		player.position = back_entrance_spawn.position
	else:
		# TODO: disable movement of enemies until dialog is done
		DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
		DialogueManager.show_example_dialogue_balloon(load("res://Dialog/bakery.dialogue"), "bakery_front")

func _on_dialogue_ended(_resource: DialogueResource):
	# TODO: enable movement of enemies
	pass
