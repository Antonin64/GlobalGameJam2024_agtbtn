extends Node2D

var time_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$boss_battle_cam.make_current()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_count += delta


