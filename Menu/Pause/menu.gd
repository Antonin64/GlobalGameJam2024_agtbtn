extends Control

func _ready():
	hide_all()

func _process(delta):
	if Input.is_action_just_pressed("enter_menu"):
		$"CanvasLayer/VBoxContainer/Return to menu".grab_focus()
		get_tree().paused = true
		show_all()

func _on_return_to_menu_pressed():
	get_tree().paused = false
	Global.scene = "res://Menu/menu.tscn"
	Global.launch_next_map()

func _on_quit_pressed():
	get_tree().quit()

func _on_resume_pressed():
	hide_all()
	get_tree().paused = false

func show_all():
	show()
	$CanvasLayer.show()

func hide_all():
	hide()
	$CanvasLayer.hide()
