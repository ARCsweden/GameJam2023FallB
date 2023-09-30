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

var weapon: Weapon = Weapon.Nothing

enum EntryPoint {
	Front,
	Back,
}

var entry_point

# TODO: Set when killing one of the staff in any way
var bakery_killed_staff = false
var killed_jean_pierre = false
var joined_carabella = false
var ran_away = false

