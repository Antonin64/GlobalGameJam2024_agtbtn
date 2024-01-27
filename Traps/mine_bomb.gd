extends Sprite2D

var player = null

@export var player_path = "../../CharacterBody2D"

func _ready():
	player = get_node(player_path)

func Kill():
	$"../GPUParticles2D".emitting = true
	queue_free()

func _on_area_2d_body_entered(body):
	if body == player:
		player.mine_exploded()
	Kill()
