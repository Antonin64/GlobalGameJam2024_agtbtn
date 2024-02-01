extends Control

var send_preload = preload("res://scores/score tab.tscn")

func _ready():
	$CanvasLayer/CheckButton.button_pressed = Global.hardcore
	$CanvasLayer/ButtonsContainer/Start.grab_focus()
	$Username.text = Global.username

func _on_start_pressed():
	Global.username = $Username.text
	Global.scene = "res://map/didac_map.tscn"
	Global.launch_next_map()

func _on_quit_pressed():
	get_tree().quit()

func _on_select_level_pressed():
	if Global.hardcore == false:
		Global.username = $Username.text
		get_tree().change_scene_to_file("res://Menu/menu_selection.tscn")

func _on_check_button_toggled(_toggled_on):
	Global.hardcore = _toggled_on
