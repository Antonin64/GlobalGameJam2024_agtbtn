extends Node2D

var time_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_count += delta

func _on_area_2d_body_entered(body):
	if body == get_node("CharacterBody2D"):
		var result = snapped(time_count, 0.01)
		if len(Global.username) > 0:
			ScoreTab_gd.add_score(str(result) + " level 2")
		Global.scene = "res://map/mapbosscopiedencule.tscn"
		Global.launch_next_map()
