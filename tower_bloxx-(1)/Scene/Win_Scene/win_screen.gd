extends Control

func _on_menu_pressed():
	# Fungsi memanggil scene mainmenu setelah button menu di press
	get_tree().change_scene_to_file("res://Scene/Level_Scene/mainmenu.tscn")

func _on_restart_pressed() -> void:
	# Fungsi memanggil scene level setelah button restart di press
	get_tree().change_scene_to_file("res://Scene/Level_Scene/level.tscn")
