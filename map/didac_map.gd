extends TileMap

var time_count = 0

func _process(delta):
	time_count += delta

func _on_area_2d_body_entered(body):
	if body == get_node("CharacterBody2D"):
		var result = snapped(time_count, 0.01)
		if len(Global.username) > 0:
			ScoreTab_gd.add_score(str(result), "0")
		Global.scene = "res://map/niveau_med.tscn"
		Global.launch_next_map()
