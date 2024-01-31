extends Control

var videos = ["res://Menu/Loading/Bacon.tscn", "res://Menu/Loading/Chips.tscn", "res://Menu/Loading/Dorito.tscn"]
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/AspectRatioContainer/ButtonsContainer/RetryBtn.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_retry_btn_pressed():
	if Global.hardcore == true:
		Global.scene = "res://map/didac_map.tscn"
	var randint = rng.randi_range(0, videos.size() - 1)
	get_tree().change_scene_to_file(videos[randint])

func _on_quit_btn_pressed():
	get_tree().quit()
