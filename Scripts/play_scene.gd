extends Node

var CardPattern = ["Spade", "Diamond", "Heart", "Clover"]
var CardNum = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]

var card:Array

func _ready():
	for pattern in CardPattern:
		for num in CardNum:
			var tmp = CardInfo.new()
			tmp.pattern = pattern
			tmp.num = num
			card.append(tmp)
	
	shuffle_card()
	#for c in card:
	#	print(c.pattern, c.num)
	
	var released_card = card.pop_front()
	$UI/VBC/Other/ReleaseCardContainer/VBC/ReleasedCard/Card.card_pattern = released_card.pattern
	$UI/VBC/Other/ReleaseCardContainer/VBC/ReleasedCard/Card.card_num = released_card.num
	#$UI/VBC/Other/ReleaseCardContainer/VBC/ReleasedCard.flip_card()
	await get_tree().create_timer(1).timeout
	$UI/VBC/Other/ReleaseCardContainer/VBC/ReleasedCard.flip_card()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func shuffle_card():
	var n = card.size()
	while n > 1:
		n -= 1
		var k = randi() % (n + 1)
		var temp = card[k]
		card[k] = card[n]
		card[n] = temp
