@tool
extends TextureRect

var num_dict = {"A" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10, "J" = 11, "Q" = 12, "K" = 13}

@export_enum("Spade", "Diamond", "Heart", "Clover") var card_pattern:String = "Spade":
	set(value):
		card_pattern = value
		if not isJoker:
			texture = load("res://cards/" + value + "-" + card_num + ".png")
@export_enum("A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K") var card_num:String = "A":
	set(value):
		card_num = value
		if not isJoker:
			texture = load("res://cards/" + card_pattern + "-" + value + ".png")
@export var isJoker:bool = false:
	set(value):
		isJoker = value
		if value:
			texture = load("res://cards/Joker.png")
		else:
			texture = load("res://cards/" + card_pattern + "-" + card_num + ".png")


func check_puttable(target):
	return card_pattern == target.card_pattern or num_dict[card_num] == num_dict[target.card_num] - 1 or num_dict[card_num] == num_dict[target.card_num] + 1
