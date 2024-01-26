extends VideoStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://map/didac_map.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
