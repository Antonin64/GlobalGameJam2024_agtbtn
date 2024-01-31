extends Node2D

var hardcore = false
var rng = RandomNumberGenerator.new()
var scene = null
var username = ""
var videos = ["res://Menu/Loading/Bacon.tscn", "res://Menu/Loading/Chips.tscn", "res://Menu/Loading/Dorito.tscn", "res://Menu/Loading/Citron.tscn", "res://Menu/Loading/Micro-onde.tscn", "res://Menu/Loading/Scie-sauteuse.tscn", "res://Menu/Loading/Tondeuse.tscn", "res://Menu/Loading/Tronconneuse.tscn"]

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _process(_delta):
	if get_tree().current_scene != null:
		var filename = get_tree().current_scene.scene_file_path
		if filename == "res://map/didac_map.tscn" or filename == "res://map/mapbosscopiedencule.tscn" or filename == "res://map/Maptuto.tscn" or filename == "res://map/niveau_med.tscn":
			if Input.is_action_just_pressed("enter_menu"):
				get_tree().change_scene_to_file("res://Menu/Pause/menu.tscn")

func launch_next_map():
	var randint = rng.randi_range(0, videos.size() - 1)
	get_tree().change_scene_to_file.bind(videos[randint]).call_deferred()
