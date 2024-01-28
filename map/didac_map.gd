extends TileMap

var videos = ["res://Menu/Loading/Bacon.tscn", "res://Menu/Loading/Chips.tscn", "res://Menu/Loading/Dorito.tscn"]
var rng = RandomNumberGenerator.new()

func launch_next_map():
	var randint = rng.randi_range(0, videos.size() - 1)
	get_tree().change_scene_to_file.bind(videos[randint]).call_deferred()

func _on_area_2d_body_entered(body):
	if body == get_node("CharacterBody2D"):
		Global.scene = "res://map/mapbosscopiedencule.tscn"
		launch_next_map()
