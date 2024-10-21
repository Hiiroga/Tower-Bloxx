extends Control

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Level_Scene/mainmenu.tscn")

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Level_Scene/level.tscn") 
