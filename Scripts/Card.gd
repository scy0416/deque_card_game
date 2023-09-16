@tool
extends TextureRect


@export_enum("Spade", "Diamond", "Heart", "Clover") var card_pattern:String = "Spade":
	set(value):
		card_pattern = value
		if not isJoker:
			texture = load("res://cards/" + value + "-" + card_num + ".png")
@export_enum("A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K") var card_num:String = "A"
@export var isJoker:bool = false:
	set(value):
		isJoker = value
		if value:
			texture = load("res://cards/Joker.png")
		else:
			texture = load("res://cards/" + card_pattern + "-" + card_num + ".png")
