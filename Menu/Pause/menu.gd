extends Control

func _ready():
	$"CanvasLayer/VBoxContainer/Return to menu".grab_focus()

func _on_return_to_menu_pressed():
	Global.scene = "res://Menu/menu.tscn"
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
