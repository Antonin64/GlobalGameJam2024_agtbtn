extends Control

var videos = ["res://Menu/Loading/Bacon.tscn", "res://Menu/Loading/Chips.tscn", "res://Menu/Loading/Dorito.tscn"]
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_retry_btn_pressed():
	var randint = rng.randi_range(0, videos.size() - 1)
	get_tree().change_scene_to_file(videos[randint])


func _on_quit_btn_pressed():
	get_tree().quit()