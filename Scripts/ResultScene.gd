extends Control


func _on_title_pressed():
	get_tree().change_scene_to_file("res://Scenes/TitleScene.tscn")


func _on_exit_pressed():
	get_tree().quit()
