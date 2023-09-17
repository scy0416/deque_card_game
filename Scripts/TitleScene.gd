extends Node

# 시작 버튼을 누르는 경우
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/play_scene.tscn")

# 규칙 버튼을 누르는 경우
func _on_rule_pressed():
	get_tree().change_scene_to_file("res://Scenes/description.tscn")

# 나가기 버튼을 누르는 경우
func _on_quit_pressed():
	get_tree().quit()
