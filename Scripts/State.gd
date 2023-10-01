extends Node

# Put global gamestate here
var italian_ally = 0

var sandwich = false

enum Weapon {  
	Nothing,
	Pen,
	Baguette,
	Croissant,
}

var weapon: Weapon = Weapon.Nothing #shows as index(int) when printed

enum EntryPoint {
	Front,
	Back,
}

var entry_point: EntryPoint = EntryPoint.Front

# TODO: Set when killing one of the staff in any way
var bakery_killed_staff = false
var killed_jean_pierre = false
var joined_carabella = false
var ran_away = false


# Textures, ugly
var tex_airplane = preload("res://Asset/BGs/airplane.png")
var tex_alley = preload("res://Asset/BGs/alley.png")
var tex_bakery = preload("res://Asset/BGs/bakery.png")
var tex_carabella = preload("res://Asset/BGs/carabella.png")
var tex_don = preload("res://Asset/BGs/don.png")
var tex_driving = preload("res://Asset/BGs/driving.png")
var tex_hitman = preload("res://Asset/BGs/hitman.png")
var tex_mafia = preload("res://Asset/BGs/mafia.png")
var tex_mansion = preload("res://Asset/BGs/mansion.png")
var tex_monaco = preload("res://Asset/BGs/monaco.png")

signal set_bg_image(texture: Texture2D)
