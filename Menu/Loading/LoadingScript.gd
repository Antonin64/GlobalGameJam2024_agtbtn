extends VideoStreamPlayer

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(8.0).timeout
	get_tree().change_scene_to_file(Global.scene)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene_to_file(Global.scene)
	pass
