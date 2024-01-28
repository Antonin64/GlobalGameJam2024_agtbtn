extends Node2D

var rng = RandomNumberGenerator.new()
var scene = null

var videos = ["res://Menu/Loading/Bacon.tscn", "res://Menu/Loading/Chips.tscn", "res://Menu/Loading/Dorito.tscn", "res://Menu/Loading/Citron.tscn", "res://Menu/Loading/Micro-onde.tscn", "res://Menu/Loading/Scie-sauteuse.tscn", "res://Menu/Loading/Tondeuse.tscn", "res://Menu/Loading/Tronconneuse.tscn"]

func launch_next_map():
	var randint = rng.randi_range(0, videos.size() - 1)
	get_tree().change_scene_to_file.bind(videos[randint]).call_deferred()
