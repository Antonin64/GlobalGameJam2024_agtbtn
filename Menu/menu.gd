extends Control

var send_preload = preload("res://scores/score tab.tscn")

func _ready():
	$CanvasLayer/ButtonsContainer/Start.grab_focus()

func _on_start_pressed():
	Global.username = $Username.text
	Global.scene = "res://map/didac_map.tscn"
	Global.launch_next_map()

func _on_quit_pressed():
	get_tree().quit()

func _on_select_level_pressed():
	Global.name = $Username.text
	get_tree().change_scene_to_file("res://Menu/menu_selection.tscn")
