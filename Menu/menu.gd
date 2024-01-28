extends Control

func _ready():
	$Menu/ButtonsContainer/Start.grab_focus()

func _on_start_pressed():
	Global.scene = "res://map/didac_map.tscn"
	Global.launch_next_map()

func _on_quit_pressed():
	get_tree().quit()

func _on_select_level_pressed():
	get_tree().change_scene_to_file("res://Menu/menu_selection.tscn")
