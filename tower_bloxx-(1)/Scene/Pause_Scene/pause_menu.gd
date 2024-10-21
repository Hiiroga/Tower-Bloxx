extends Control

@onready var main = $"../.."
func _on_resume_pressed() -> void:
	main.PauseMenu() 

func _on_button_pressed() -> void:
	main.PauseMenu() 


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Level_Scene/mainmenu.tscn")  # Replace with function body.
