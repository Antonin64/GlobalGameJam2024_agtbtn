extends Control

var videos = ["res://Menu/Loading/Bacon.tscn", "res://Menu/Loading/Chips.tscn", "res://Menu/Loading/Dorito.tscn"]
var rng = RandomNumberGenerator.new()

func _ready():
	$Menu/ButtonsContainer/Start.grab_focus()

func _on_start_pressed():
	Global.scene = "res://map/didac_map.tscn"
	var randint = rng.randi_range(0, videos.size() - 1)
	get_tree().change_scene_to_file(videos[randint])

func _on_quit_pressed():
	get_tree().quit()
