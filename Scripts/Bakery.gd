extends Node2D

@onready var player = $YSort/Player
@onready var back_entrance_spawn = $BackEntranceSpawn
@onready var exit_area = $ExitArea

@onready var enemy1 = $YSort/Enemies/MeleeEnemy
@onready var enemy2 = $YSort/Enemies/MeleeEnemy2
@onready var enemy3 = $YSort/Enemies/MeleeEnemy3

# Called when the node enters the scene tree for the first time.
func _ready():
	exit_area.connect("body_entered", _exit_area_entered)
	if State.entry_point == State.EntryPoint.Back:
		player.position = back_entrance_spawn.position
		player.able_to_attack=true
	else:
		# Disable movement of enemies until dialog is done
		player.SPEED=0
		enemy1.SPEED=0
		enemy2.SPEED=0
		enemy3.SPEED=0
		DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
		DialogueManager.show_example_dialogue_balloon(load("res://Dialog/bakery.dialogue"), "bakery_front")

func _on_dialogue_ended(_resource: DialogueResource):
	# Enable movement of enemies
	player.SPEED=1000
	enemy1.SPEED=200
	enemy2.SPEED=200
	enemy3.SPEED=200
	player.able_to_attack=true

func _exit_area_entered(_body):
	get_tree().change_scene_to_file("res://Scenes/Kitchen.tscn")
