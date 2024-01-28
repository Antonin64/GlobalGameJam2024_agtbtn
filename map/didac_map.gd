extends TileMap

func _on_area_2d_body_entered(body):
	if body == get_node("CharacterBody2D"):
		Global.scene = "res://map/mapbosscopiedencule.tscn"
		Global.launch_next_map()
