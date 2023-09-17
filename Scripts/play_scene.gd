extends Node
signal check_start

var CardPattern = ["Spade", "Diamond", "Heart", "Clover"]
var CardNum = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]

var card:Array

var card_scene:PackedScene = preload("res://Scenes/card.tscn")

var remain_cards:int:
	set(value):
		remain_cards = value
		$UI/VBC/Life.value = value

func _ready():
	for pattern in CardPattern:
		for num in CardNum:
			var tmp = CardInfo.new()
			tmp.pattern = pattern
			tmp.num = num
			card.append(tmp)
	
	remain_cards = 52
	
	shuffle_card()
	#for c in card:
	#	print(c.pattern, c.num)
	
	var released_card = card.pop_front()
	$UI/VBC/Other/ReleaseCardContainer/VBC/ReleasedCard/Card.card_pattern = released_card.pattern
	$UI/VBC/Other/ReleaseCardContainer/VBC/ReleasedCard/Card.card_num = released_card.num
	#$UI/VBC/Other/ReleaseCardContainer/VBC/ReleasedCard.flip_card()
	await get_tree().create_timer(1).timeout
	$UI/VBC/Other/ReleaseCardContainer/VBC/ReleasedCard.flip_card()
	remain_cards -= 1
	
	for i in range(0, 5):
		var c = card.pop_front()
		append_back(c)
		remain_cards -= 1
		await get_tree().create_timer(1).timeout
	
	#start_game()
	emit_signal("check_start")


func shuffle_card():
	var n = card.size()
	while n > 1:
		n -= 1
		var k = randi() % (n + 1)
		var temp = card[k]
		card[k] = card[n]
		card[n] = temp


func append_front(c:CardInfo):
	var card_instance = card_scene.instantiate()
	card_instance.card_pattern = c.pattern
	card_instance.card_num = c.num
	$UI/VBC/Hand/ReleaseFront.add_sibling(card_instance)
	pass


func append_back(c:CardInfo):
	var card_instance = card_scene.instantiate()
	card_instance.card_pattern = c.pattern
	card_instance.card_num = c.num
	var nodes_size = $UI/VBC/Hand.get_child_count()
	var target_node = $UI/VBC/Hand.get_child(nodes_size - 3)
	target_node.add_sibling(card_instance)
	pass


func start_game():
	check_state()


func check_state():
	var released_card = $UI/VBC/Other/ReleaseCardContainer/VBC/ReleasedCard/Card
	var front_card = $UI/VBC/Hand.get_child(2)
	var back_card = $UI/VBC/Hand.get_child($UI/VBC/Hand.get_child_count() - 3)
	
	if $UI/VBC/Hand.get_child_count() == 4:
		get_tree().change_scene_to_file("res://Scenes/win.tscn")
	
	var front_puttable = released_card.check_puttable(front_card)
	var back_puttable = released_card.check_puttable(back_card)
	
	$UI/VBC/Hand/ReleaseFront.visible = false
	$UI/VBC/Hand/ReleaseBack.visible = false
	$UI/VBC/Hand/PutFront.visible = false
	$UI/VBC/Hand/PutBack.visible = false
	
	if front_puttable or back_puttable:
		$UI/VBC/Hand/ReleaseFront.visible = front_puttable
		$UI/VBC/Hand/ReleaseBack.visible = back_puttable
	else:
		if remain_cards == 0:
			get_tree().change_scene_to_file("res://Scenes/lose.tscn")
		next_card_open()
		$UI/VBC/Hand/PutFront.visible = true
		$UI/VBC/Hand/PutBack.visible = true


func next_card_open():
	var flip_card = $UI/VBC/Other/CardFile/VBC/FlipCard/Card
	var next_card = card.pop_front()
	flip_card.card_pattern = next_card.pattern
	flip_card.card_num = next_card.num
	$UI/VBC/Other/CardFile/VBC/FlipCard.flip_card()


func _on_release_front_pressed():
	var released_card = $UI/VBC/Other/ReleaseCardContainer/VBC/ReleasedCard/Card
	var front_card = $UI/VBC/Hand.get_child(2)
	released_card.card_pattern = front_card.card_pattern
	released_card.card_num = front_card.card_num
	front_card.queue_free()
	await get_tree().create_timer(0.01).timeout
	emit_signal("check_start")


func _on_release_back_pressed():
	var released_card = $UI/VBC/Other/ReleaseCardContainer/VBC/ReleasedCard/Card
	var back_card = $UI/VBC/Hand.get_child($UI/VBC/Hand.get_child_count() - 3)
	released_card.card_pattern = back_card.card_pattern
	released_card.card_num = back_card.card_num
	back_card.queue_free()
	await get_tree().create_timer(0.01).timeout
	emit_signal("check_start")


func _on_put_front_pressed():
	var new_card = card_scene.instantiate()
	var target = $UI/VBC/Other/CardFile/VBC/FlipCard/Card
	new_card.card_pattern = target.card_pattern
	new_card.card_num = target.card_num
	$UI/VBC/Hand/ReleaseFront.add_sibling(new_card)
	$UI/VBC/Other/CardFile/VBC/FlipCard/AnimationPlayer.stop()
	remain_cards -= 1
	await get_tree().create_timer(0.01).timeout
	emit_signal("check_start")


func _on_put_back_pressed():
	var new_card = card_scene.instantiate()
	var target = $UI/VBC/Other/CardFile/VBC/FlipCard/Card
	new_card.card_pattern = target.card_pattern
	new_card.card_num = target.card_num
	$UI/VBC/Hand.get_child($UI/VBC/Hand.get_child_count() - 3).add_sibling(new_card)
	$UI/VBC/Other/CardFile/VBC/FlipCard/AnimationPlayer.stop()
	remain_cards -= 1
	await get_tree().create_timer(0.01).timeout
	emit_signal("check_start")
