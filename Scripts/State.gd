extends Node

# Put global gamestate here
var italian_ally = 0

enum Weapons {
	Nothing,
	Sandwich,
	Pen,
}

var weapon: Weapons = Weapons.Nothing

enum EntryPoint {
	Front,
	Back,
}

var entry_point
